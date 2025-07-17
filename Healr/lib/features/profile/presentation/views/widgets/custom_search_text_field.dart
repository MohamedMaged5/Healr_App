import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search your records',
          hintStyle: Styles.textStyle14.copyWith(
            color: Colors.grey,
          ),
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: const Color(0xff999999),
          ),
          suffixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedMic01,
            color: const Color(0xff666666),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: kSecondaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }
}
