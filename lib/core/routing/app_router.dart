import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/auth/presentation/profile_setup_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/booking/presentation/address_selection_screen.dart';
import '../../features/booking/presentation/assigned_worker_tracking_screen.dart';
import '../../features/booking/presentation/booking_details_screen.dart';
import '../../features/booking/presentation/booking_form_screen.dart';
import '../../features/booking/presentation/booking_history_screen.dart';
import '../../features/booking/presentation/searching_worker_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/role_selection_screen.dart';
import '../../features/payments/presentation/payment_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/profile/presentation/user_profile_screen.dart';
import '../../features/profile/presentation/worker_profile_screen.dart';
import '../../features/ratings/presentation/review_screen.dart';
import '../../features/ratings/presentation/worker_reviews_screen.dart';
import '../../features/services/presentation/service_details_screen.dart';
import '../../features/support/presentation/support_screen.dart';
import '../../features/user_home/presentation/user_home_screen.dart';
import '../../features/worker_dashboard/presentation/earnings_screen.dart';
import '../../features/worker_dashboard/presentation/worker_dashboard_screen.dart';
import '../../features/worker_jobs/presentation/active_job_details_screen.dart';
import '../../features/worker_jobs/presentation/document_upload_screen.dart';
import '../../features/worker_jobs/presentation/incoming_job_request_screen.dart';
import '../../features/worker_jobs/presentation/job_history_screen.dart';
import '../../features/worker_jobs/presentation/service_selection_screen.dart';
import '../../features/worker_jobs/presentation/worker_map_screen.dart';
import '../../features/worker_jobs/presentation/worker_onboarding_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashScreen.routePath,
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: OnboardingScreen.routePath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoleSelectionScreen.routePath,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: LoginScreen.routePath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: OtpVerificationScreen.routePath,
        builder: (context, state) => OtpVerificationScreen(
          verificationId: state.uri.queryParameters['verificationId'] ?? '',
          phoneNumber: state.uri.queryParameters['phone'] ?? '',
        ),
      ),
      GoRoute(
        path: ProfileSetupScreen.routePath,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: UserHomeScreen.routePath,
        builder: (context, state) => const UserHomeScreen(),
      ),
      GoRoute(
        path: ServiceDetailsScreen.routePath,
        builder: (context, state) => ServiceDetailsScreen(
          serviceId: state.pathParameters['serviceId'] ?? '',
        ),
      ),
      GoRoute(
        path: AddressSelectionScreen.routePath,
        builder: (context, state) => const AddressSelectionScreen(),
      ),
      GoRoute(
        path: BookingFormScreen.routePath,
        builder: (context, state) => BookingFormScreen(
          serviceId: state.pathParameters['serviceId'] ?? '',
        ),
      ),
      GoRoute(
        path: SearchingWorkerScreen.routePath,
        builder: (context, state) => SearchingWorkerScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: AssignedWorkerTrackingScreen.routePath,
        builder: (context, state) => AssignedWorkerTrackingScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: BookingDetailsScreen.routePath,
        builder: (context, state) => BookingDetailsScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: BookingHistoryScreen.routePath,
        builder: (context, state) => const BookingHistoryScreen(),
      ),
      GoRoute(
        path: PaymentScreen.routePath,
        builder: (context, state) => PaymentScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: ChatScreen.routePath,
        builder: (context, state) => ChatScreen(
          roomId: state.pathParameters['roomId'] ?? '',
        ),
      ),
      GoRoute(
        path: ReviewScreen.routePath,
        builder: (context, state) => ReviewScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: NotificationsScreen.routePath,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: SettingsScreen.routePath,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: SupportScreen.routePath,
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: UserProfileScreen.routePath,
        builder: (context, state) => const UserProfileScreen(),
      ),
      GoRoute(
        path: WorkerDashboardScreen.routePath,
        builder: (context, state) => const WorkerDashboardScreen(),
      ),
      GoRoute(
        path: DocumentUploadScreen.routePath,
        builder: (context, state) => const DocumentUploadScreen(),
      ),
      GoRoute(
        path: WorkerOnboardingScreen.routePath,
        builder: (context, state) => const WorkerOnboardingScreen(),
      ),
      GoRoute(
        path: ServiceSelectionScreen.routePath,
        builder: (context, state) => const ServiceSelectionScreen(),
      ),
      GoRoute(
        path: IncomingJobRequestScreen.routePath,
        builder: (context, state) => IncomingJobRequestScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: ActiveJobDetailsScreen.routePath,
        builder: (context, state) => ActiveJobDetailsScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: WorkerMapScreen.routePath,
        builder: (context, state) => WorkerMapScreen(
          bookingId: state.pathParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        path: EarningsScreen.routePath,
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: JobHistoryScreen.routePath,
        builder: (context, state) => const JobHistoryScreen(),
      ),
      GoRoute(
        path: WorkerReviewsScreen.routePath,
        builder: (context, state) => const WorkerReviewsScreen(),
      ),
      GoRoute(
        path: WorkerProfileScreen.routePath,
        builder: (context, state) => const WorkerProfileScreen(),
      ),
    ],
  );
});
