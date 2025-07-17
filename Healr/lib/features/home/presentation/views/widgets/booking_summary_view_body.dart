import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/appoint_cache.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appointment.dart';
import 'package:healr/features/home/presentation/managers/Appointment/appointment_cubit.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/book2_header.dart';
import 'package:healr/features/home/presentation/views/widgets/details_statement.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_info.dart';
import 'package:healr/features/home/presentation/views/widgets/health_insurance_discount_skeleton.dart';
import 'package:healr/features/home/presentation/views/widgets/icon_statement.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';

class BookingSummaryViewBody extends StatefulWidget {
  const BookingSummaryViewBody({super.key, this.data, this.appointDetails});
  final Datum? data;
  final Appointment? appointDetails;

  @override
  State<BookingSummaryViewBody> createState() => _BookingSummaryViewBodyState();
}

class _BookingSummaryViewBodyState extends State<BookingSummaryViewBody> {
  @override
  void initState() {
    BlocProvider.of<HealthInsuranceCubit>(context).getHealthInsurance();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Appointment booked successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          GoRouter.of(context).pushReplacement(
            AppRouter.kBookingConfirmationView,
            extra: {
              'data': widget.data,
              'appointDetails': state.appointDetails,
            },
          );
        } else if (state is AppointmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Failed to book appointment: ${state.errorMessage}"),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<AppointmentCubit, AppointmentState>(
                builder: (context, state) {
                  return CustomButton(
                    text: state is AppointmentLoading
                        ? "Booking..."
                        : "Confirm Booking",
                    onPressed: state is AppointmentLoading
                        ? null
                        : () async {
                            await BlocProvider.of<BookingCubit>(context)
                                .bookAppointment();
                            String formattedDay = appointDay!;
                            String formattedTime = appointTime!;

                            BlocProvider.of<AppointmentCubit>(context)
                                .createAppointment(
                                    widget.data!.id!,
                                    formattedDay,
                                    formattedTime,
                                    widget.data!.name!);
                          },
                    padding: 0,
                  );
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                  "You will receive a reminder 24 hours prior to your appointment.",
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Book2Header(title: "Review Summary"),
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
              DetailsStatement(
                  label: "Date & hour",
                  detail: "$appointDay, 2025 | $appointTime"),
              SizedBox(height: 16.h),
              const DetailsStatement(
                  label: "Type", detail: "In Person Consultation"),
              SizedBox(height: 16.h),
              const DetailsStatement(label: "Booking for", detail: "Self"),
              SizedBox(height: 20.h),
              const Divider(
                thickness: 1,
                color: Color(0xffCCCCCC),
              ),
              SizedBox(height: 16.h),
              DetailsStatement(
                  label: "Amount",
                  detail: "${widget.data?.price ?? "300"} L.E."),
              SizedBox(height: 16.h),
              BlocBuilder<HealthInsuranceCubit, HealthInsuranceState>(
                builder: (context, state) {
                  if (state is HealthInsuranceLoading) {
                    return const HealthInsuranceDiscountSkeleton();
                  } else if (state is HealthInsuranceFetched) {
                    return const DetailsStatement(
                      label: "Health Insurance discount",
                      detail: "-50 L.E.",
                    );
                  } else if (state is HealthInsuranceEmpty) {
                    return const DetailsStatement(
                      label: "Health Insurance discount",
                      detail: "-0 L.E.",
                    );
                  } else if (state is HealthInsuranceError) {
                    return const DetailsStatement(
                      label: "Health Insurance discount",
                      detail: "-0 L.E.",
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 20.h),
              const Divider(
                thickness: 1,
                color: Color(0xffCCCCCC),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<HealthInsuranceCubit, HealthInsuranceState>(
                  builder: (context, state) {
                if (state is HealthInsuranceLoading) {
                  return const HealthInsuranceDiscountSkeleton();
                } else if (state is HealthInsuranceFetched) {
                  return DetailsStatement(
                    label: "Total",
                    detail: "${(widget.data?.price ?? 300) - 50} L.E.",
                  );
                } else if (state is HealthInsuranceEmpty) {
                  return DetailsStatement(
                    label: "Total",
                    detail: "${widget.data?.price ?? 300} L.E.",
                  );
                } else if (state is HealthInsuranceError) {
                  return DetailsStatement(
                    label: "Total",
                    detail: "${widget.data?.price ?? 300} L.E.",
                  );
                }
                return const SizedBox();
              }),
              SizedBox(height: 16.h),
              const Divider(
                thickness: 1,
                color: Color(0xffCCCCCC),
              ),
              SizedBox(height: 16.h),
              const IconStatement(
                icon: "assets/images/cash.svg",
                label: "Payment with Cash",
              ),
            ],
          ),
        )),
      ),
    ));
  }
}
