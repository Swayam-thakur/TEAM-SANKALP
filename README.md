# QuickSeva

QuickSeva is a Flutter Android-first on-demand services app with role-based user and worker flows in one codebase. It uses Riverpod for state management, GoRouter for navigation, and Firebase-first backend integrations for auth, Firestore, storage, messaging, analytics, and real-time booking orchestration.

## 1. Project Architecture And Folder Structure

The app follows a clean, feature-first structure with four practical layers:

- `presentation`: screens, widgets, routing targets
- `application`: Riverpod controllers, async flows, state orchestration
- `domain/data`: typed models and Firebase-backed repositories
- `core/shared`: theme, errors, services, utilities, common widgets, providers

Top-level structure:

```text
lib/
  core/
  features/
  shared/
functions/
android/
assets/mock/
```

## 2. pubspec.yaml

Main packages included:

- Firebase: `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`, `firebase_messaging`, `firebase_crashlytics`, `firebase_analytics`
- App: `flutter_riverpod`, `go_router`, `google_maps_flutter`, `geolocator`, `geocoding`, `flutter_local_notifications`, `url_launcher`, `uuid`
- Utilities: `dio`, `connectivity_plus`, `shared_preferences`, `image_picker`, `file_picker`, `intl`

## 3. Firebase Setup Instructions

1. Install Flutter and Firebase CLI locally.
2. Run `flutter pub get`.
3. Run `flutterfire configure` and replace the placeholder values in `lib/firebase_options.dart`.
4. Add `android/app/google-services.json`.
5. Set `MAPS_API_KEY` in `android/local.properties` or Gradle environment config.
6. In `functions/`, run `npm install` and `npm run build`.
7. Deploy backend assets with `firebase deploy --only firestore:rules,firestore:indexes,functions`.

## 4. Data Models

Typed models included in `lib/shared/models/`:

- `AppUser`
- `WorkerProfile`
- `WorkerDocument`
- `WorkerLocation`
- `ServiceCategory`
- `AddressModel`
- `BookingModel`
- `ChatRoom`
- `ChatMessage`
- `PaymentRecord`
- `ReviewModel`
- `NotificationItem`
- `EarningRecord`
- `SupportTicket`

These models already map to Firestore-compatible JSON and preserve null safety.

## 5. Repositories And Services

Firebase-backed repositories are under `lib/shared/repositories/`:

- auth
- users
- workers
- services
- bookings
- chat
- payments
- notifications
- reviews
- support

Shared services in `lib/core/services/` include:

- connectivity
- location and reverse geocoding
- push/local notification bootstrap
- payment gateway abstraction

## 6. State Management / Providers

Riverpod is used throughout:

- session/auth providers
- catalog/search providers
- booking lifecycle providers
- worker dashboard and location providers
- chat streams
- notifications streams
- payment, review, and support controllers

All repository dependencies are injected through `lib/shared/providers/app_providers.dart`.

## 7. Authentication Flow

Implemented flow:

1. `SplashScreen`
2. `OnboardingScreen`
3. `RoleSelectionScreen`
4. `LoginScreen`
5. `OtpVerificationScreen`
6. `ProfileSetupScreen`

Phone OTP is wired through Firebase Auth. Worker profile setup also persists worker-specific service categories and service radius.

## 8. User App Screens

Implemented user-side screens:

- home with search and categories
- service details
- booking form
- address saving
- searching worker
- assigned worker live tracking
- booking details
- booking history
- payment
- chat
- notifications
- profile
- settings
- support
- review submission

## 9. Worker App Screens

Implemented worker-side screens:

- dashboard with online/offline state
- document upload
- service category selection
- incoming request screen
- active job lifecycle screen
- live map screen
- earnings and wallet
- job history
- ratings list
- worker profile

Worker onboarding is handled across role selection, profile setup, document upload, and service selection so the codebase can later split into a dedicated worker app without rewriting the underlying models.

## 10. Booking And Matching Logic

Client flow implemented:

1. user selects service
2. app captures current location
3. booking document is created with `searchingWorker`
4. Cloud Functions shortlist eligible nearby workers
5. workers receive request alerts
6. first accepted worker is assigned transactionally
7. user tracks worker location in real time
8. worker updates lifecycle states
9. payment and review flow complete the booking

Important protections already included:

- transaction-based acceptance
- request expiry handling
- live worker location collection
- role-based access control hooks
- request shortlist persistence with `requestedWorkerIds`

## 11. Chat And Notifications

- Firestore-backed booking chat rooms and messages
- FCM token hooks in profile creation
- local notifications for foreground messages
- notification collection for in-app alerts
- Cloud Functions writes booking/job notifications

## 12. Payment Abstraction

`lib/core/services/payment_gateway.dart` exposes a clean abstraction so you can plug in Razorpay later without changing the screen layer. The current implementation records placeholder payment state into Firestore and supports:

- cash on service
- online placeholder
- worker wallet history
- admin commission-ready earnings records

## 13. Ratings And Reviews

Implemented:

- user-to-worker review submission
- worker review feed
- Firestore-backed review repository

The schema supports worker-to-user reviews later if you want bilateral ratings.

## 14. Firestore Collection Schema Suggestions

Collections expected by this scaffold:

- `users`
- `workers`
- `services`
- `bookings`
- `worker_locations`
- `chat_rooms`
- `chat_rooms/{roomId}/messages`
- `payments`
- `reviews`
- `notifications`
- `worker_documents`
- `saved_addresses`
- `earnings`
- `support_tickets`

Recommended important fields:

- `bookings.status`
- `bookings.requestedWorkerIds`
- `bookings.requestWindowEndsAt`
- `workers.serviceIds`
- `workers.verificationStatus`
- `workers.online`
- `worker_locations.latitude`
- `worker_locations.longitude`
- `worker_locations.geohash`

## 15. Firestore Rules

`firestore.rules` includes baseline protections for:

- self-owned user and worker docs
- booking participant reads/updates
- admin-only service/payment/earnings control
- saved addresses bound to creator
- notification ownership
- support ticket ownership

Review the rules before production, especially if you add admin dashboards, disputes, refunds, or worker-to-worker features.

## 16. Cloud Functions Outline

Implemented in `functions/src/index.ts`:

- `onBookingCreated`
  - loads eligible workers
  - calculates distance
  - persists a shortlist
  - sends notifications
- `acceptBooking`
  - callable function
  - transactionally locks assignment
  - prevents duplicate acceptance
- `onBookingUpdated`
  - mirrors status changes into notifications
- `expireStaleBookings`
  - scheduled cleanup for timeouts
- `syncWorkerGeohash`
  - computes geohash after worker location updates

For production, extend this with:

- batch retries when workers reject
- callable reject endpoint with audit trail
- Razorpay payment webhooks
- dispute escalation
- richer ETA/routing support

## Running The App

1. Install Flutter 3.22+ and Android toolchain.
2. Run `flutter pub get`.
3. Configure Firebase and Google Maps keys.
4. Run `flutter run`.

## Important Notes

- This workspace did not have Flutter installed, so native wrappers were created manually and were not validated with `flutter analyze` or `flutter run` in this environment.
- Replace placeholder Firebase values before running.
- The current payment gateway is intentionally abstract and placeholder-based.
- If you plan to enable background worker tracking in production, add Android foreground service handling and platform-specific review for battery optimizations.
