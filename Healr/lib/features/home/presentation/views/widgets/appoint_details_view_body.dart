import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/widgets/book2_header.dart';
import 'package:healr/features/home/presentation/views/widgets/details_statement.dart';
import 'package:healr/features/home/presentation/views/widgets/doctor_info.dart';
import 'package:healr/features/home/presentation/views/widgets/health_insurance_discount_skeleton.dart';
import 'package:healr/features/home/presentation/views/widgets/icon_statement.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';

class AppointDetailsViewBody extends StatefulWidget {
  const AppointDetailsViewBody({super.key, this.data, this.appointDetails});
  final Datum? data;
  final AppointDetailsModel? appointDetails;

  @override
  State<AppointDetailsViewBody> createState() => _AppointDetailsViewBodyState();
}

class _AppointDetailsViewBodyState extends State<AppointDetailsViewBody> {
  @override
  void initState() {
    BlocProvider.of<HealthInsuranceCubit>(context).getHealthInsurance();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: CustomButton(
          text: "Back to Home",
          onPressed: () {
            GoRouter.of(context).pushReplacement(
              AppRouter.kHomeView,
              extra: {
                'data': widget.data,
                'appointDetails': widget.appointDetails,
              },
            );
          },
          padding: 0,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Book2Header(title: "Appointment Details"),
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
                label: "Appointment ID",
                detail:
                    "${widget.appointDetails!.data!.appointment!.appointmentId}"),
            SizedBox(height: 16.h),
            DetailsStatement(
                label: "Date & hour",
                detail:
                    "${widget.appointDetails!.data!.appointment!.day}, 2025 | ${widget.appointDetails!.data!.appointment!.time}"),
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
                label: "Amount", detail: "${widget.data?.price ?? "300"} L.E."),
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
    ));
  }
}
