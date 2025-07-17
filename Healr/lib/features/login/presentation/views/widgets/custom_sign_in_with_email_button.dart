import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class CustomSignInWithEmailButton extends StatelessWidget {
  const CustomSignInWithEmailButton({super.key, this.onTap , this.text = 'Sign in with Email'});

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: kSecondaryColor,
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/mail.svg',
                height: 24.h,
                width: 24.w,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: Styles.textStyle20.copyWith(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
