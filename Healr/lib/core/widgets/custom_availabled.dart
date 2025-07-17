import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';

class CustomAvailable extends StatelessWidget {
  const CustomAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      width: 192.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0xffD5E9F6),
      ),
      child: Text(
        "Available",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Styles.textStyle14.copyWith(
          fontWeight: FontWeight.w600,
          color: const Color(0xff666666),
        ),
      ),
    );
  }
}
