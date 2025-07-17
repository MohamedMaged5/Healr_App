import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/views/widgets/details_statement.dart';

class WorkingHours extends StatelessWidget {
  const WorkingHours({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Working hours",
          style: Styles.textStyle20.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        const Divider(
          thickness: 1,
          color: Color(0xffCCCCCC),
        ),
        SizedBox(height: 4.h),
        const DetailsStatement(
          label: "Saturday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
        const DetailsStatement(
          label: "Sunday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
        const DetailsStatement(
          label: "Monday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
        const DetailsStatement(
          label: "Tuesday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
        const DetailsStatement(
          label: "Wednesday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
        const DetailsStatement(
          label: "Thursday",
          detail: "09:00AM - 03:00PM",
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
