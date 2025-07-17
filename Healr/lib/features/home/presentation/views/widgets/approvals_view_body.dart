import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_back_button.dart';
import 'package:healr/features/home/presentation/managers/approvals/approvals_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/approval_card.dart';
import 'package:healr/features/home/presentation/views/widgets/refresh_status_button.dart';

class ApprovalsViewBody extends StatelessWidget {
  const ApprovalsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomBackButton(
                    marginLeft: 0,
                  ),
                  SizedBox(width: 12.w),
                  Text("Approvals",
                      style: Styles.textStyle24.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              SizedBox(height: 28.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/info-circle.svg"),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "Approval requests submitted during your visit will appear here for tracking. Check status for each medication, test, or procedure as reviewed by your insurance.",
                      style: Styles.textStyle14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              RefreshStatusButton(
                onTap: () {
                  BlocProvider.of<ApprovalsCubit>(context).loadApprovals();
                },
              ),
              SizedBox(height: 24.h),
              BlocBuilder<ApprovalsCubit, ApprovalsState>(
                builder: (context, state) {
                  if (state is ApprovalsInitial) {
                    return Column(
                      children: [
                        const ApprovalCard(
                          label: "Test: CT Scan",
                          submittedBy: "Ismailia Medical Complex",
                          submittedDate: "May 10, 2025",
                          statusContainerColor: Color(0xffF0FDF4),
                          statusIcon: Icons.check,
                          statusWord: "Approved",
                          statusWordIconColor: Color(0xff079903),
                          statusStatment: "Coverage: 60%",
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        const ApprovalCard(
                          label: "Procedure: Hand Cast",
                          submittedBy: "AlKhair W AlBaraka Hospital",
                          submittedDate: "April 10, 2025",
                          statusContainerColor: Color(0xffFEF2F2),
                          statusIcon: Icons.close,
                          statusWord: "Denied",
                          statusWordIconColor: Color(0xffD80000),
                          statusStatment: "Not Included in Policy",
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        const ApprovalCard(
                          label: "Medication: Insulin Glargine",
                          submittedBy: "Ismailia Medical Complex",
                          submittedDate: "April 29, 2025",
                          statusContainerColor: Color(0xffFEFCE8),
                          statusIcon: Icons.watch_later_outlined,
                          statusWord: "Pending",
                          statusWordIconColor: Color(0xffCA8A04),
                          statusStatment: "Awaiting Insurance review",
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    );
                  } else if (state is ApprovalsLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
