import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDoctorImage extends StatelessWidget {
  const CustomDoctorImage({
    super.key,
    required this.doctorImg,
  });

  final String? doctorImg;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 66.w,
        height: 95.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xffD5E9F6).withAlpha(70),
          image: doctorImg != null && doctorImg!.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage("$doctorImg"),
                  fit: BoxFit.cover,
                )
              : const DecorationImage(
                  image: AssetImage("assets/images/doctor_prof_image.png"),
                  fit: BoxFit.cover),
        ));
  }
}
