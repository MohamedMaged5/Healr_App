import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';

class CustomPasswordValidtionSentence extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  const CustomPasswordValidtionSentence({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 22.sp,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: Styles.textStyle12,
          )
        ],
      ),
    );
  }
}
