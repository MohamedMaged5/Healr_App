import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class NoHealthInsuranceViewBody extends StatelessWidget {
  const NoHealthInsuranceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                text: "Health Insurance",
              ),
              const Spacer(
                flex: 2,
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/images/No_health_insurance.svg",
                  width: 250.w,
                  height: 250.h,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(HugeIcons.strokeRoundedAlertCircle),
                  SizedBox(width: 4.w),
                  Text(
                    "No Insurance Card Found.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                "Add a valid health insurance card to simplify your bookings and approvals.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                color: const Color(0xFF3A95D2),
                text: "Add Health Insurance Card",
                padding: 0,
                isIcon: true,
                icon: HugeIcons.strokeRoundedAddCircle,
                onPressed: () {
                  GoRouter.of(context).push(
                    AppRouter.kHealthInsuranceFormView,
                  );
                },
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
