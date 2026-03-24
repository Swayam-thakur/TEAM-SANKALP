import * as admin from 'firebase-admin';
import { geohashForLocation, distanceBetween } from 'geofire-common';
import { onDocumentCreated, onDocumentUpdated } from 'firebase-functions/v2/firestore';
import { onCall, HttpsError } from 'firebase-functions/v2/https';
import { onSchedule } from 'firebase-functions/v2/scheduler';

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

type Booking = {
  id: string;
  userId: string;
  workerId?: string;
  serviceId: string;
  serviceName: string;
  status: string;
  requestedWorkerIds?: string[];
  address: {
    latitude: number;
    longitude: number;
  };
};

type WorkerProfile = {
  id: string;
  name: string;
  online: boolean;
  serviceIds: string[];
  radiusKm: number;
  verificationStatus: string;
  availability: string;
  notificationToken?: string;
};

type WorkerLocation = {
  workerId: string;
  latitude: number;
  longitude: number;
  updatedAt: string;
};

export const onBookingCreated = onDocumentCreated(
  'bookings/{bookingId}',
  async (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      return;
    }

    const booking = snapshot.data() as Booking;
    if (booking.status !== 'searchingWorker') {
      return;
    }

    const workersSnapshot = await db
      .collection('workers')
      .where('online', '==', true)
      .where('verificationStatus', '==', 'approved')
      .where('availability', '==', 'online')
      .where('serviceIds', 'array-contains', booking.serviceId)
      .get();

    const candidates: Array<{
      worker: WorkerProfile;
      location: WorkerLocation;
      distanceKm: number;
    }> = [];

    for (const doc of workersSnapshot.docs) {
      const worker = doc.data() as WorkerProfile;
      const locationDoc = await db.collection('worker_locations').doc(worker.id).get();
      if (!locationDoc.exists) {
        continue;
      }

      const location = locationDoc.data() as WorkerLocation;
      const distanceKm =
        distanceBetween(
          [booking.address.latitude, booking.address.longitude],
          [location.latitude, location.longitude],
        ) * 1.60934;

      if (distanceKm <= worker.radiusKm) {
        candidates.push({ worker, location, distanceKm });
      }
    }

    candidates.sort((a, b) => a.distanceKm - b.distanceKm);
    const shortlist = candidates.slice(0, 5);
    const requestedWorkerIds = shortlist.map((item) => item.worker.id);

    await snapshot.ref.set(
      {
        status: requestedWorkerIds.length > 0 ? 'workerNotified' : 'expired',
        requestedWorkerIds,
        requestWindowEndsAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 25 * 1000),
        ),
      },
      { merge: true },
    );

    for (const item of shortlist) {
      await db.collection('notifications').doc().set({
        userId: item.worker.id,
        title: `New ${booking.serviceName} request`,
        body: `Customer nearby. Accept quickly to lock the booking.`,
        type: 'jobRequest',
        bookingId: booking.id,
        read: false,
        createdAt: admin.firestore.Timestamp.now(),
      });

      if (item.worker.notificationToken) {
        await messaging.send({
          token: item.worker.notificationToken,
          notification: {
            title: `New ${booking.serviceName} request`,
            body: 'A nearby customer is waiting.',
          },
          data: {
            bookingId: booking.id,
            route: `/worker/request/${booking.id}`,
          },
        });
      }
    }
  },
);

export const acceptBooking = onCall(async (request) => {
  const workerId = request.auth?.uid;
  const bookingId = request.data.bookingId as string | undefined;

  if (!workerId || !bookingId) {
    throw new HttpsError('failed-precondition', 'Missing worker authentication or booking ID.');
  }

  await db.runTransaction(async (transaction) => {
    const bookingRef = db.collection('bookings').doc(bookingId);
    const bookingSnapshot = await transaction.get(bookingRef);
    if (!bookingSnapshot.exists) {
      throw new HttpsError('not-found', 'Booking not found.');
    }

    const booking = bookingSnapshot.data() as Booking;
    if (booking.workerId && booking.workerId !== workerId) {
      throw new HttpsError('already-exists', 'Booking already assigned.');
    }

    if (!booking.requestedWorkerIds?.includes(workerId)) {
      throw new HttpsError('permission-denied', 'Worker was not invited to this booking.');
    }

    const roomId = booking.id.startsWith('chat_') ? booking.id : `chat_${booking.id}`;

    transaction.set(
      bookingRef,
      {
        workerId,
        status: 'workerAssigned',
        chatRoomId: roomId,
        requestedWorkerIds: admin.firestore.FieldValue.delete(),
      },
      { merge: true },
    );

    transaction.set(
      db.collection('workers').doc(workerId),
      {
        availability: 'busy',
        currentBookingId: bookingId,
      },
      { merge: true },
    );
  });

  return { success: true };
});

export const onBookingUpdated = onDocumentUpdated(
  'bookings/{bookingId}',
  async (event) => {
    const before = event.data?.before.data() as Booking | undefined;
    const after = event.data?.after.data() as Booking | undefined;
    if (!before || !after || before.status === after.status) {
      return;
    }

    const recipients = [after.userId, after.workerId].filter(Boolean) as string[];
    for (const userId of recipients) {
      await db.collection('notifications').doc().set({
        userId,
        title: 'Booking update',
        body: `Booking ${after.id} is now ${after.status}.`,
        type: 'bookingUpdate',
        bookingId: after.id,
        read: false,
        createdAt: admin.firestore.Timestamp.now(),
      });
    }
  },
);

export const expireStaleBookings = onSchedule('every 5 minutes', async () => {
  const now = admin.firestore.Timestamp.now();
  const snapshot = await db
    .collection('bookings')
    .where('status', 'in', ['searchingWorker', 'workerNotified'])
    .where('requestWindowEndsAt', '<=', now)
    .get();

  const batch = db.batch();
  snapshot.docs.forEach((doc) => {
    batch.set(
      doc.ref,
      {
        status: 'expired',
        requestedWorkerIds: [],
      },
      { merge: true },
    );
  });
  await batch.commit();
});

export const syncWorkerGeohash = onDocumentUpdated(
  'worker_locations/{workerId}',
  async (event) => {
    const after = event.data?.after;
    if (!after?.exists) {
      return;
    }

    const data = after.data() as WorkerLocation;
    const geohash = geohashForLocation([data.latitude, data.longitude]);
    await after.ref.set({ geohash }, { merge: true });
  },
);

