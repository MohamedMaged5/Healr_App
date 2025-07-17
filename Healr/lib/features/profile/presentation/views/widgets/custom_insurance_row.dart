import 'package:flutter/material.dart';
import 'package:healr/core/utils/styles.dart';

class CustomInsuranceRow extends StatelessWidget {
  const CustomInsuranceRow({super.key, required this.text1, required this.text2});
  final String text1, text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xff666666),
          ),
        ),
        Text(
          text2,
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color(0xff1A1A1A),
          ),
        ),
      ],
    );
  }
}
