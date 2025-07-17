import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class RefreshStatusButton extends StatelessWidget {
  final Function()? onTap;
  const RefreshStatusButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: const Color(0xffB3B3B3),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/refresh.svg"),
            SizedBox(
              width: 8.w,
            ),
            Text("Refresh Status",
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1A1A1A),
                ))
          ],
        ),
      ),
    );
  }
}
