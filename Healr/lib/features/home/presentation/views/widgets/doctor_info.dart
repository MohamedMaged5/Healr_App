import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_profile_image.dart';
import 'package:healr/features/home/presentation/views/widgets/location_row.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    required this.data,
  });

  final Datum? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorProfileImage(data: data),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.name ?? "",
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(data?.specialization ?? "",
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  )),
              SizedBox(
                height: 8.h,
              ),
              const LocationRow(),
            ],
          ),
        )
      ],
    );
  }
}
