import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/styles.dart';

void showCustomDialog({
  required BuildContext context,
  required String  message,
  required Duration duration,
  required String iconPath,
  VoidCallback? onDismiss,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(duration, () {
        if (onDismiss != null) {
          onDismiss();
        } else {
          GoRouter.of(context).pop();
        }
      });

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 80.h,
                width: 80.w,
              ),
              SizedBox(height: 20.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
