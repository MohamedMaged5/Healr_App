import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/onborading/presentation/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  Future<void> completeOnboarding(BuildContext context) async {
    await SharedPrefCache.saveCache(
        key: 'onboardingStatus', value: 'completed');
    GoRouter.of(context).go(AppRouter.kLoginView);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        'imagePath': 'assets/images/doctors.png',
        'indicatorPath': 'assets/images/indicator 1.svg',
        'text1': 'Welcome to ',
        'text2': 'healr.\n',
        'text3': 'Your health partner, anytime,\nanywhere',
        'bottom': 225.h,
        'left': 0.w,
        'right': 0.w,
        'height': 341.h,
        'width': 351.w,
        'textColor': const Color(0xFF3A95D2),
        'styles': const TextStyle(
          color: Color(0xFF3A95D2),
          fontWeight: FontWeight.w700,
        ),
      },
      {
        'imagePath': 'assets/images/female.png',
        'indicatorPath': 'assets/images/indicator 2.svg',
        'text1': 'Need an appointment?\n',
        'text2': 'Choose a doctor, check',
        'text3': 'availability, and book instantly',
        'bottom': 270.h,
        'left': 0.w,
        'right': 0.w,
        'height': 313.h,
        'width': 249.w,
        'textColor': const Color(0xFF000000),
        'styles': const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      },
      {
        'imagePath': 'assets/images/clock.png',
        'indicatorPath': 'assets/images/indicator 3.svg',
        'text1': 'Stay on track with your meds!\n',
        'text2': 'Get timely reminders so you',
        'text3': 'never miss a dose',
        'bottom': 350.h,
        'left': 0.w,
        'right': 0.w,
        'height': 240.h,
        'width': 393.w,
        'textColor': const Color(0xFF000000),
        'styles': const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: OnboardingViewBody(
            pages: pages,
            onLastPageTap: () {
              GoRouter.of(context).push(AppRouter.kLoginView);
              completeOnboarding(context);
            }),
      ),
    );
  }
}
