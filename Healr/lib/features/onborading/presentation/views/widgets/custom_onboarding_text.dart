import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/onborading/presentation/views/widgets/custom_positioned_text.dart';

class CustomOnboardingText extends StatelessWidget {
  const CustomOnboardingText({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.textColor,
    required this.styles,
  });

  final String text1, text2, text3;
  final Color textColor;
  final TextStyle styles;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 170.h,
          left: 10.w,
          right: 0.w,
          child: Text.rich(
            TextSpan(
              text: text1,
              style: Styles.textStyle22.copyWith(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: text2,
                  style: styles,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomPositionedText(
          text: text3,
          bottom: 135.h,
          left: 0.w,
          right: 0.w,
        )
      ],
    );
  }
}
