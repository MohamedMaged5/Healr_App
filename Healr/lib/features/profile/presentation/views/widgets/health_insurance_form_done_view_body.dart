import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';

class HealthInsuranceFormDoneViewBody extends StatelessWidget {
  const HealthInsuranceFormDoneViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/success.svg',
              width: 100.w,
              height: 100.h,
            ),
            SizedBox(height: 24.h),
            Text(
              textAlign: TextAlign.center,
              'Health Insurance Card successfully added!',
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xff1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your health insurance card has been verified and saved. It will now be automatically applied to all future booking requests.',
              textAlign: TextAlign.center,
              style: Styles.textStyle14.copyWith(
                color: const Color(0xff1A1A1A),
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              color: const Color(0xffE0E0E0),
              thickness: 1,
              height: 32.h,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: 16,
                    padding: 0.w,
                    textStyle: Styles.textStyle14.copyWith(
                      color: const Color(0xff3A95D2),
                      fontWeight: FontWeight.w700,
                    ),
                    text: 'Go to Home',
                    onPressed: () {
                      GoRouter.of(context).push(
                        AppRouter.kHomeView,
                      );
                    },
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomButton(
                    borderRadius: 16,
                    padding: 0.w,
                    textStyle: Styles.textStyle14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    text: 'Booking Appointment',
                    onPressed: () {
                      GoRouter.of(context).pushReplacement(
                        AppRouter.kBookAppointView,
                      );
                    },
                    color: const Color(0xFF3A95D2),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
