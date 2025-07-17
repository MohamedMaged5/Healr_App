import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_decorated_container.dart';

class CustomMedicalContainer extends StatelessWidget {
  const CustomMedicalContainer({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 400.w,
      decoration: BoxDecoration(
        color: const Color(0xffEBFFEE),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff00001A).withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomDecoratedContainer(
                  borderColor: Color(0xff3A95D2),
                  textColor: Color(0xff3A95D2),
                  text: 'Consultation',
                ),
                Text(
                  '2025-03-16',
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Dr. Ahmed Mahmoud',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
                Text(
                  ' (Dermatologist)',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Monthly routine checkup, Updated prescriptions.',
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xff666666),
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: onTap,
              child: const CustomDecoratedContainer(
                borderColor: Color(0xff1A1A1A),
                textColor: Color(0xff1A1A1A),
                text: 'Lab Results (3) attached',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
