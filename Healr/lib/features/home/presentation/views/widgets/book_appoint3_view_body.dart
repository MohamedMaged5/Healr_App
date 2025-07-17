import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/presentation/managers/selected_day/selected_day_cubit.dart';
import 'package:healr/features/home/presentation/managers/selected_time/selected_time_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/book2_header.dart';
import 'package:healr/features/home/presentation/views/widgets/choose_appoint_day.dart';
import 'package:healr/features/home/presentation/views/widgets/choose_appoint_time.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_info.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_stats.dart';

class BookAppoint3ViewBody extends StatelessWidget {
  const BookAppoint3ViewBody({super.key, this.data});
  final Datum? data;

  void _showValidationMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<SelectedDayCubit, SelectedDayState>(
          builder: (context, dayState) {
            return BlocBuilder<SelectedTimeCubit, SelectedTimeState>(
              builder: (context, timeState) {
                // Check if both day and time are selected
                final bool isDaySelected = dayState is SelectedDay &&
                    dayState.selectedIndexDay != null;
                final bool isTimeSelected = timeState is SelectedTimeInitial &&
                    timeState.selectedIndexTime != null;
                final bool canProceed = isDaySelected && isTimeSelected;

                return CustomButton(
                  text: "Book appointment",
                  onPressed: canProceed
                      ? () {
                          GoRouter.of(context)
                              .push(AppRouter.kBookingSummaryView, extra: data);
                        }
                      : () {
                          // Show appropriate validation message
                          if (!isDaySelected) {
                            _showValidationMessage(
                                context, "Please select an appointment day");
                          } else if (!isTimeSelected) {
                            _showValidationMessage(
                                context, "Please select an appointment time");
                          }
                        },
                  padding: 0,
                );
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              DoctorStats(data: data),
              SizedBox(height: 16.h),
              Text(
                "Book Appointment",
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff666666),
                ),
              ),
              SizedBox(height: 16.h),
              const ChooseAppointDay(),
              SizedBox(
                height: 16.h,
              ),
              const ChooseAppointTime(),
            ],
          ),
        ),
      ),
    ));
  }
}
