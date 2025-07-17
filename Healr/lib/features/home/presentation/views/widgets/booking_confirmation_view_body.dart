import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/managers/Appointment/appointment_cubit.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/appoint_details_container.dart';
import 'package:healr/features/home/presentation/views/widgets/view_appoint_details_button.dart';

class BookingConfirmationViewBody extends StatelessWidget {
  const BookingConfirmationViewBody(
      {super.key, this.data, this.appointDetails});
  final Datum? data;
  final AppointDetailsModel? appointDetails;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        GoRouter.of(context).pushReplacement(
          AppRouter.kHomeView,
          extra: {
            'data': data,
            'appointDetails': appointDetails,
          },
        );
        return Future.value(false);
      },
      child: BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentCancelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Appointment cancelled successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            GoRouter.of(context).pushReplacement(
              AppRouter.kHomeView,
            );
          } else if (state is AppointmentCancelFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text("Failed to cancel appointment: ${state.errorMessage}"),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CustomBackButton(
              marginLeft: 10.w,
              onTap: () {
                GoRouter.of(context).pushReplacement(
                  AppRouter.kHomeView,
                  extra: {
                    'data': data,
                    'appointDetails': appointDetails,
                  },
                );
              },
            ),
            title: Text(
              "Back to Home",
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 62.h,
                ),
                SvgPicture.asset(
                  "assets/images/green_check.svg",
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Appointment Confirmed",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                    "Your visit with ${data!.name} is scheduled for ${appointDetails!.data!.appointment!.day}, ${appointDetails!.data!.appointment!.time}.",
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff666666),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                AppointDetailsContainer(
                  appointDetails: appointDetails,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    BlocBuilder<AppointmentCubit, AppointmentState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is AppointmentCancelLoading
                              ? null
                              : () async {
                                  await BlocProvider.of<BookingCubit>(context)
                                      .cancelAppointment();
                                  String formattedAppointID =
                                      appointDetails!.data!.appointment!.id!;
                                  BlocProvider.of<AppointmentCubit>(context)
                                      .cancelAppointment(formattedAppointID);
                                },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(110.w, 40.h),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                color: kSecondaryColor,
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Text(
                            state is AppointmentCancelLoading
                                ? "Loading.."
                                : "Cancel",
                            style: Styles.textStyle14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kSecondaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    ViewAppointDetailsButton(
                      text: "View Appointment Details",
                      onPressed: () {
                        GoRouter.of(context).push(
                          AppRouter.kAppointDetailsView,
                          extra: {
                            'data': data,
                            'appointDetails': appointDetails,
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
