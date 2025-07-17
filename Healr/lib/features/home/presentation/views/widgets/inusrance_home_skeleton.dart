import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InusranceHomeSkeleton extends StatelessWidget {
  const InusranceHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: Container(
          height: 78.h,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 8.h,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add your health insurance',
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffF8F8F8),
                    ),
                  ),
                  Text(
                    'Book a doctor and save consultation fees with\n insurance.',
                    style: Styles.textStyle12.copyWith(
                      fontWeight: FontWeight.w300,
                      color: const Color(0xffE6E6E6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
