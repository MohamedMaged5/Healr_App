import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:healr/features/home/data/repos/places_repo.dart';
import 'package:healr/features/home/presentation/managers/places_cubit/cubit/places_cubit.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/appoint_details_view.dart';
import 'package:healr/features/home/presentation/views/approvals_view.dart';
import 'package:healr/features/home/presentation/views/book_appoint2_view.dart';
import 'package:healr/features/home/presentation/views/book_appoint3_view.dart';
import 'package:healr/features/home/presentation/views/book_appoint_view.dart';
import 'package:healr/features/home/presentation/views/booking_confirmation_view.dart';
import 'package:healr/features/home/presentation/views/booking_summary_view.dart';
import 'package:healr/features/home/presentation/views/doctor_profile_view.dart';
import 'package:healr/features/home/presentation/views/home_view.dart';
import 'package:healr/features/home/presentation/views/our_doctors_view.dart';
import 'package:healr/features/home/presentation/views/test_results_view.dart';
import 'package:healr/features/home/presentation/views/map_view.dart';
import 'package:healr/features/login/presentation/views/forget_password_view.dart';
import 'package:healr/features/login/presentation/views/login_view.dart';
import 'package:healr/features/login/presentation/views/login_with_email_view.dart';
import 'package:healr/features/login/presentation/views/new_password_view.dart';
import 'package:healr/features/login/presentation/views/password_changed_view.dart';
import 'package:healr/features/login/presentation/views/verification_code_view.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/ui/views/medicine_details_view.dart';
import 'package:healr/features/notification/ui/views/medicine_view.dart';
import 'package:healr/features/notification/ui/views/notification_view.dart';
import 'package:healr/features/onborading/presentation/views/onboarding_view.dart';
import 'package:healr/features/onborading/splash_view.dart';
import 'package:healr/features/profile/presentation/views/health_insurance_form_done_view.dart';
import 'package:healr/features/profile/presentation/views/health_insurance_form_view.dart';
import 'package:healr/features/profile/presentation/views/health_insurance_view.dart';
import 'package:healr/features/profile/presentation/views/help_center_view.dart';
import 'package:healr/features/profile/presentation/views/medical_history_view.dart';
import 'package:healr/features/profile/presentation/views/no_health_insurance_view.dart';
import 'package:healr/features/profile/presentation/views/privacy_policy_view.dart';
import 'package:healr/features/profile/presentation/views/profile_view.dart';
import 'package:healr/features/profile/presentation/views/your_profile_view.dart';
import 'package:healr/features/search/presentation/views/search_view.dart';
import 'package:healr/features/sign_up/presentation/views/sign_up_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/OnboardingView';
  static const kLoginView = '/LoginView';
  static const kLoginWithEmailView = '/LoginWithEmailView';
  static const kSignUpView = '/SignUpView';
  static const kHomeView = '/HomeView';
  static const kForgetPasswordView = '/ForgetPasswordView';
  static const kVerificationCodeView = '/VerificationCodeView';
  static const kNewPasswordView = '/NewPasswordView';
  static const kPasswordChangedView = '/PasswordChangedView';
  static const kChatbotView = '/ChatbotView';
  static const kProfileView = '/ProfileView';
  static const kYourProfileView = '/YourProfileView';
  static const kPrivacyPolicyView = '/PrivacyPolicyView';
  static const kHelpCenterView = '/HelpCenterView';
  static const kHealthInsuranceView = '/HealthInsuranceView';
  static const kMedicalHistoryView = '/MedicalHistoryView';
  static const kNotificationView = '/NotificationView';
  static const kBookAppointView = '/BookAppointView';
  static const kBookAppoint2View = '/BookAppoint2View';
  static const kBookAppoint3View = '/BookAppoint3View';
  static const kBookingSummaryView = '/BookingSummaryView';
  static const kBookingConfirmationView = '/BookingConfirmationView';
  static const kAppointDetailsView = '/AppointDetailsView';
  static const kOurDoctorsView = '/OurDoctorsView';
  static const kDoctorProfileView = "/DoctorProfileView";
  static const kTestResultsView = '/TestResultsView';
  static const kMedicineView = '/MedicineView';
  static const kMedicineDetailsView = '/MedicineDetailsView';
  static const kNoHealthInsuranceView = '/NoHealthInsuranceView';
  static const kHealthInsuranceFormView = '/HealthInsuranceFormView';
  static const kHealthInsuranceFormDoneView = '/HealthInsuranceFormDoneView';
  static const kMapView = '/MapView';
  static const kApprovalsView = '/ApprovalsView';
  static const kSearchview = '/SearchView';
  static final router = GoRouter(
    initialLocation: kSplashView,
    routes: [
      GoRoute(
        path: kSplashView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final Datum? data = extra?['data'];
          final AppointDetailsModel? appointDetails = extra?['appointDetails'];

          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeView(
              data: data,
              appointDetails: appointDetails,
            ),
            transitionsBuilder: customNavigateAnimation,
          );
        },
      ),
      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kLoginWithEmailView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginWithEmailView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kForgetPasswordView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgetPasswordView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kVerificationCodeView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const VerificationCodeView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kNewPasswordView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NewPasswordView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kPasswordChangedView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PasswordChangedView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kNotificationView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kChatbotView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ChatbotView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kProfileView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kYourProfileView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const YourProfileView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kPrivacyPolicyView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PrivacyPolicyView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHelpCenterView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HelpCenterView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHealthInsuranceView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HealthInsuranceView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kMedicalHistoryView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MedicalHistoryView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kBookAppointView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookAppointView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kBookAppoint2View,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookAppoint2View(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kBookAppoint3View,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookAppoint3View(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kBookingSummaryView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookingSummaryView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kBookingConfirmationView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookingConfirmationView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kAppointDetailsView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AppointDetailsView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kOurDoctorsView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OurDoctorsView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kDoctorProfileView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DoctorProfileView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kTestResultsView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TestResultsView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kMedicineView,
        pageBuilder: (context, state) {
          final meds = state.extra as List<MedicineModel>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MedicineView(med: meds),
            transitionsBuilder: customNavigateAnimation,
          );
        },
      ),
      GoRoute(
        path: kMedicineDetailsView,
        pageBuilder: (context, state) {
          final meds = state.extra as List<MedicineModel>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MedicineDetailsView(
              meds: meds,
            ),
            transitionsBuilder: customNavigateAnimation,
          );
        },
      ),
      GoRoute(
        path: kNoHealthInsuranceView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NoHealthInsuranceView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHealthInsuranceFormView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HealthInsuranceFormView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHealthInsuranceFormDoneView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HealthInsuranceFormDoneView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kMapView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => PlacesCubit(
              PlacesRepo(dio: Dio())
                ..getNearbyHospitals(lat: 30.6140389, lng: 32.2937089),
            ),
            child: const MapView(),
          ),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kApprovalsView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ApprovalsView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kSearchview,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SearchView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
    ],
  );
}

Widget customNavigateAnimation(context, animation, secondaryAnimation, child) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeOut;

  final tween = Tween(begin: begin, end: end).chain(
    CurveTween(curve: curve),
  );
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
