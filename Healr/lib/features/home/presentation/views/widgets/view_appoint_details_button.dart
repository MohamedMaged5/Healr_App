import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';

class ViewAppointDetailsButton extends StatelessWidget {
  const ViewAppointDetailsButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(239.w, 40.h),
        backgroundColor: kSecondaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r), side: BorderSide.none),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Styles.textStyle14.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
