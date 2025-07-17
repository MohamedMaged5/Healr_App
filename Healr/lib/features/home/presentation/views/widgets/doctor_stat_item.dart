import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';

class DoctorStatsItem extends StatelessWidget {
  final String icon;
  final String count;
  final String label;
  const DoctorStatsItem({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: const Color(0xffD5E9F6),
          child: SvgPicture.asset(icon),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          count,
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xff3A95D2),
          ),
        ),
        Text(
          label,
          style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500, color: const Color(0xff666666)),
        )
      ],
    );
  }
}
