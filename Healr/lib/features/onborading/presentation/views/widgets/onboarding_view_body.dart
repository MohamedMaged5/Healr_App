import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/onborading/presentation/views/widgets/custom_indicator.dart';
import 'package:healr/features/onborading/presentation/views/widgets/custom_positioned_image.dart';
import 'package:healr/features/onborading/presentation/views/widgets/custom_onboarding_text.dart';
import 'package:healr/features/onborading/presentation/views/widgets/header_section.dart';

class OnboardingViewBody extends StatefulWidget {
  final List<Map<String, dynamic>> pages;
  final VoidCallback onLastPageTap;

  const OnboardingViewBody({
    super.key,
    required this.pages,
    required this.onLastPageTap,
  });

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          itemCount: widget.pages.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final page = widget.pages[index];
            return Stack(
              children: [
                HeaderSection(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
                    SharedPrefCache.saveCache(
                        key: 'onboardingStatus', value: 'completed');
                  },
                ),
                Stack(
                  children: [
                    if (index == 0)
                      CustomPositionedImage(
                        bottom: 360.h,
                        left: 0.h,
                        right: 0.h,
                        height: 269.h,
                        width: 282.w,
                        imagePath: 'assets/images/circles.png',
                      ),
                    CustomPositionedImage(
                      bottom: page['bottom'],
                      left: 0.w,
                      right: 0.w,
                      height: page['height'],
                      width: page['width'],
                      imagePath: page['imagePath'],
                    ),
                    CustomPositionedImage(
                      bottom: page['bottom'],
                      left: 0.w,
                      right: 0.w,
                      height: page['height'],
                      width: page['width'],
                      imagePath: page['imagePath'],
                    ),
                    CustomPositionedImage(
                      bottom: 0.h,
                      left: 0.h,
                      right: 0.h,
                      height: 320.h,
                      width: 393.w,
                      imagePath: 'assets/images/Vector.png',
                    ),
                    CustomOnboardingText(
                      styles: page['styles'],
                      text1: page['text1'],
                      text2: page['text2'],
                      text3: page['text3'],
                      textColor: page['textColor'],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 50.h,
          left: 0.w,
          right: 0.w,
          child: GestureDetector(
            onTap: () {
              if (currentPage < widget.pages.length - 1) {
                controller.animateToPage(
                  currentPage + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              } else {
                widget.onLastPageTap();
              }
            },
            child: CustomIndicator(
              pageIndex: currentPage,
              indicatorPath: widget.pages[currentPage]['indicatorPath'],
              onIndicatorTap: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
