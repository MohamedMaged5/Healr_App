import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_availabled.dart';
import 'package:healr/core/widgets/custom_book_button.dart';
import 'package:healr/core/widgets/custom_doctor_image.dart';
import 'package:healr/core/widgets/custom_professional_doctor.dart';
import 'package:healr/core/widgets/custom_rating.dart';

class DoctorCard extends StatelessWidget {
  final String? doctorImg;
  final String? doctorName;
  final String? doctorSpecialty;
  final double? rating;
  final void Function()? onPressed;
  final String? lcoationIcon;
  final String? locationText;
  final String? dollarIcon;
  final String? dollarText;
  final String label;
  const DoctorCard(
      {super.key,
      this.doctorImg,
      this.rating,
      this.doctorName,
      this.doctorSpecialty,
      this.onPressed,
      this.lcoationIcon,
      this.locationText,
      this.dollarIcon,
      this.dollarText,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color: const Color(0xffCCCCCC),
        ),
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDoctorImage(doctorImg: doctorImg),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomProfessionalDoctor(),
                  SizedBox(height: 4.h),
                  Text(doctorName ?? "",
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 4.h),
                  Text(
                    doctorSpecialty ?? "",
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff666666),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  CustomRating(
                    rating: rating,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 8.h),
          lcoationIcon != null && lcoationIcon!.isNotEmpty
              ? Row(
                  children: [
                    SvgPicture.asset(lcoationIcon!),
                    SizedBox(width: 4.w),
                    Text(locationText ?? "",
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                )
              : const SizedBox(),
          lcoationIcon != null && lcoationIcon!.isNotEmpty
              ? SizedBox(height: 8.h)
              : const SizedBox(),
          dollarIcon != null && dollarIcon!.isNotEmpty
              ? Row(
                  children: [
                    SvgPicture.asset(dollarIcon!),
                    SizedBox(width: 4.w),
                    Text(dollarText ?? "",
                        style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              const CustomAvailable(),
              SizedBox(width: 12.w),
              CustomBookButton(label: label, onPressed: onPressed),
            ],
          )
        ],
      ),
    );
  }
}
