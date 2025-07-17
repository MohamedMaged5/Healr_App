import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class EmptyChatBot extends StatelessWidget {
  const EmptyChatBot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
        SvgPicture.asset(
          'assets/images/healrbot 1.svg',
          colorFilter:
              const ColorFilter.mode(Color(0xffFCFCFC), BlendMode.modulate),
        ),
        SizedBox(height: 20.h),
        Text(
          'Meet healr bot, Your caregiver',
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          "healr cares for your health—learn about booking appointments, describe how you feel to give you health advice",
          style: Styles.textStyle12,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
