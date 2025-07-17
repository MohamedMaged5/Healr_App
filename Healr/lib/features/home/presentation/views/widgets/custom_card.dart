import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String imgUrl, title, subtitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: const Color(0xff8D8D8D),
        color: const Color(0xffEFF6FF),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                imgUrl,
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A1A1A),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: Styles.textStyle10.copyWith(
                  color: const Color(0xff4D4D4D),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
