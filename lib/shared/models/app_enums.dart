enum UserRole {
  user,
  worker,
}

enum BookingStatus {
  pending,
  searchingWorker,
  workerNotified,
  workerAssigned,
  workerOnTheWay,
  arrived,
  workStarted,
  completed,
  paymentPending,
  paymentCompleted,
  cancelled,
  expired,
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

enum WorkerAvailability {
  online,
  offline,
  busy,
}

enum VerificationStatus {
  pending,
  approved,
  rejected,
}

enum DocumentType {
  idProof,
  serviceProof,
  profilePhoto,
}

enum SupportTicketStatus {
  open,
  inProgress,
  resolved,
}

enum NotificationType {
  jobRequest,
  bookingAccepted,
  bookingUpdate,
  bookingCancelled,
  payment,
  review,
  support,
}

