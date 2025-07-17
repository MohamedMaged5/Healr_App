import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';

class PasswordChangedViewBody extends StatelessWidget {
  const PasswordChangedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              "assets/images/password changed.svg",
              alignment: Alignment.center,
            ),
            SizedBox(height: 12.h),
            Text(
              "Password changed!",
              textAlign: TextAlign.center,
              style: Styles.textStyle24.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Your password has been reset  successfully",
              textAlign: TextAlign.center,
              style: Styles.textStyle14,
            ),
            SizedBox(height: 16.h),
            CustomButton(
                text: "Back to Sign in",
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kLoginView);
                }),
          ],
        ),
      ),
    );
  }
}
