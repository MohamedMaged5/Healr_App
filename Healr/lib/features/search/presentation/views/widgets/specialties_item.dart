import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class SpecialtiesItem extends StatelessWidget {
  const SpecialtiesItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });
  final String title;
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.w),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xffCCCCCC),
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              color: kSecondaryColor,
            ),
            SizedBox(width: 8.w),
            Text(title,
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500,
                )),
            const Spacer(),
            SvgPicture.asset(
              "assets/images/arrow forward.svg",
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
