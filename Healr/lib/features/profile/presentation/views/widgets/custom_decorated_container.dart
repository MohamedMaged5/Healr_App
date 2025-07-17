import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDecoratedContainer extends StatelessWidget {
  const CustomDecoratedContainer({
    super.key,
    required this.borderColor,
    required this.textColor,
    required this.text,
  });

  final Color borderColor, textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
