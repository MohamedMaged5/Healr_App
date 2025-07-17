import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';

class CustomMedicineRow extends StatelessWidget {
  const CustomMedicineRow({
    super.key,
    required this.text1,
    required this.text2,
    required this.icon,
    this.isMedicine = false,
  });

  final String text1, text2;
  final IconData icon;
  final bool isMedicine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xff3A95D2),
          size: 32.sp,
        ),
        SizedBox(width: 8.w),
        isMedicine
            ? Text.rich(
                TextSpan(
                  text: text1,
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff3A95D2),
                  ),
                  children: [
                    TextSpan(
                      text: text2,
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                '$text1$text2',
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff3A95D2),
                ),
              ),
      ],
    );
  }
}
