import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class SendMessage extends StatelessWidget {
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  const SendMessage({
    super.key,
    this.onTap,
    this.onSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        hintText: 'Any symptoms bothering you?',
        hintStyle: Styles.textStyle14.copyWith(
          color: const Color(0xff4D4D4D),
        ),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(5.r),
            child: SvgPicture.asset(
              "assets/images/send message.svg",
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xff999999)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
        filled: false,
      ),
    );
  }
}
