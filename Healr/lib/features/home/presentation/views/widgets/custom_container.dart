import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.imgUrl, required this.title, this.onTap});

  final String imgUrl, title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          color: const Color(0xfff8F8F8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff8D8D8D),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 4.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgUrl,
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: Styles.textStyle12.copyWith(
                  height: 1,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1A1A1A),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
