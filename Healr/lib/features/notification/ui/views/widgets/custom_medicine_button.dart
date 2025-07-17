import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomMedicineButton extends StatelessWidget {
  const CustomMedicineButton({
    super.key,
    required this.decoration,
    required this.onPressed,
    required this.color,
    required this.icon,
    required this.text1,
    required this.text2,
    required this.textStyle,
    this.isAdded = false,
  });

  final BoxDecoration? decoration;
  final void Function()? onPressed;
  final Color color;
  final IconData icon;
  final String text1;
  final String text2;
  final TextStyle? textStyle;
  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 16.w,
          ),
          child: Row(
            children: [
              HugeIcon(
                icon: icon,
                color: color,
                size: 24.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(isAdded ? text1 : text2, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
