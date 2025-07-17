import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';

class DoctorProfileImage extends StatelessWidget {
  const DoctorProfileImage({
    super.key,
    required this.data,
  });

  final Datum? data;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.r,
      backgroundColor: const Color(0xffD5E9F6).withAlpha(70),
      backgroundImage: NetworkImage(
        data?.image ?? "",
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: SvgPicture.asset(
          "assets/images/blue check.svg",
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
  }
}
