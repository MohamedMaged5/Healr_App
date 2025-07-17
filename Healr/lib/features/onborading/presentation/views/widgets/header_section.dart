import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/icon.svg',
            height: 77.h,
            width: 70.w,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Skip',
              style: Styles.textStyle18.copyWith(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
