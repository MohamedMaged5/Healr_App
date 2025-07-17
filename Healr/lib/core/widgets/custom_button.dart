import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.padding = 16.0,
    this.isIcon = false,
    this.icon,
    this.color,
    this.textStyle,
    this.textColor,
    this.borderRadius = 10.0,
    this.borderColor,
    this.iconColor,
  });

  final void Function()? onPressed;
  final String text;
  final double padding;
  final bool isIcon;
  final IconData? icon;
  final Color? color, textColor, borderColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding.w,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? kSecondaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            side: BorderSide(color: borderColor ?? const Color(0xFF3A95D2)),
          ),
        ),
        onPressed: onPressed,
        child: isIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24.sp,
                    color: iconColor ?? Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    text,
                    style: textStyle ??
                        Styles.textStyle20.copyWith(
                          color: textColor ?? Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              )
            : Text(
                textAlign: TextAlign.center,
                text,
                style: textStyle ??
                    Styles.textStyle20.copyWith(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
      ),
    );
  }
}
