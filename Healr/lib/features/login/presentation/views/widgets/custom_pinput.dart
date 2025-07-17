import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends StatelessWidget {
  const CustomPinPut({
    super.key,
    required TextEditingController pinController,
    this.errorText,
    this.validator,
  }) : _pinController = pinController;
  final String? errorText;
  final TextEditingController _pinController;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      controller: _pinController,
      useNativeKeyboard: true,
      keyboardType: TextInputType.number,

      errorText: errorText,
      // textInputAction: TextInputAction.done,
      closeKeyboardWhenCompleted: true,
      errorTextStyle: Styles.textStyle14
          .copyWith(color: kErrorColor, fontWeight: FontWeight.w500),
      defaultPinTheme: PinTheme(
        width: 70.w,
        height: 72.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        textStyle: Styles.textStyle32.copyWith(
          fontWeight: FontWeight.w400,
          color: kSecondaryColor,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: kSecondaryColor),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 70.w,
        height: 72.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        textStyle: Styles.textStyle32.copyWith(
          fontWeight: FontWeight.w400,
          color: kSecondaryColor,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffD5E9F6),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: kSecondaryColor),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 70.w,
        height: 72.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        textStyle: Styles.textStyle32.copyWith(
          fontWeight: FontWeight.w400,
          color: const Color(0xffEE584A),
        ),
        decoration: BoxDecoration(
          color: const Color(0xffFDE9E8),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: const Color(0xffEE584A)),
        ),
      ),
      validator: validator,
    );
  }
}
