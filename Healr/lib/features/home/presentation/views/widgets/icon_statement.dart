import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class IconStatement extends StatelessWidget {
  final String icon;
  final String label;
  const IconStatement({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(icon),
        SizedBox(
          width: 8.w,
        ),
        Text(
          label,
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
