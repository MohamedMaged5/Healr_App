import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';

class CustomRating extends StatelessWidget {
  final double? rating;
  const CustomRating({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: const Color(0xffFACC15), size: 18.sp),
        SizedBox(
          width: 2.w,
        ),
        Text(rating.toString(),
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
