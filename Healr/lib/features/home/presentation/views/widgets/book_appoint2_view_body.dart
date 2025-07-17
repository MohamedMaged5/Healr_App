import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/presentation/views/widgets/book2_header.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_info.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_reviews.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_stats.dart';
import 'package:healr/features/home/presentation/views/widgets/working_hours.dart';

class BookAppoint2ViewBody extends StatelessWidget {
  const BookAppoint2ViewBody({
    super.key,
    this.data,
  });

  final Datum? data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.r),
          child: CustomButton(
            text: "Book Appointment",
            onPressed: () {
              GoRouter.of(context)
                  .push(AppRouter.kBookAppoint3View, extra: data);
            },
            padding: 0,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Book2Header(
                  title: "Book appointment",
                ),
                SizedBox(height: 24.h),
                DoctorInfo(data: data),
                SizedBox(
                  height: 28.h,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xffCCCCCC),
                ),
                SizedBox(height: 16.h),
                DoctorStats(
                  data: data,
                ),
                SizedBox(height: 16.h),
                Text(
                  "About Doctor:",
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Dr. ${data!.name} is a qualified and experienced doctor who cares deeply about patients. Known for clear diagnoses and effective treatments, the doctor uses up-to-date medical knowledge to provide trusted and personal care.",
                  style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff666666)),
                ),
                SizedBox(height: 16.h),
                const WorkingHours(),
                SizedBox(height: 16.h),
                DoctorReviews(
                  review: data?.reviews,
                  doctorId: data?.id,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
