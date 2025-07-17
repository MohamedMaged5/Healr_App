import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/presentation/views/widgets/book2_header.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_info.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_reviews.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_stats.dart';
import 'package:healr/features/home/presentation/views/widgets/working_hours.dart';
import 'package:healr/features/home/presentation/views/widgets/write_review_button.dart';

class DoctorProfileViewBody extends StatefulWidget {
  const DoctorProfileViewBody({
    super.key,
    this.data,
    this.showReviews = true,
  });
  final Datum? data;
  final bool showReviews;

  @override
  State<DoctorProfileViewBody> createState() => _DoctorProfileViewBodyState();
}

class _DoctorProfileViewBodyState extends State<DoctorProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Book2Header(
                  title: "Our Doctors",
                ),
                SizedBox(height: 24.h),
                DoctorInfo(data: widget.data),
                SizedBox(
                  height: 28.h,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xffCCCCCC),
                ),
                SizedBox(height: 16.h),
                DoctorStats(
                  data: widget.data,
                ),
                SizedBox(height: 16.h),
                Text(
                  "About Doctor",
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Dr. ${widget.data!.name} is a qualified and experienced doctor who cares deeply about patients. Known for clear diagnoses and effective treatments, the doctor uses up-to-date medical knowledge to provide trusted and personal care.",
                  style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff666666)),
                ),
                SizedBox(height: 16.h),
                const WorkingHours(),
                SizedBox(height: 16.h),
                if (widget.showReviews) ...[
                  DoctorReviews(
                    review: widget.data?.reviews,
                    doctorId: widget.data?.id,
                  ),
                  WriteReviewButton(
                    doctorId: widget.data?.id,
                  ),
                ],
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
