import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class CustomProfessionalDoctor extends StatelessWidget {
  const CustomProfessionalDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 147.w,
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffD5E9F6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/blue check.svg"),
          SizedBox(
            width: 4.w,
          ),
          Text(
            "Professional Doctor",
            style: Styles.textStyle12.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xff2673A6),
            ),
          ),
        ],
      ),
    );
  }
}
