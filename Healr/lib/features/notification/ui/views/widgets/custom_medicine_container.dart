import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_medicine_row.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomMedicineContainer extends StatelessWidget {
  const CustomMedicineContainer({
    super.key,
    required this.medicineName,
    required this.dosage,
    required this.numberOfTimes,
  });

  final String medicineName;
  final String dosage;
  final int numberOfTimes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xffEFF6FF),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            CustomMedicineRow(
              text1: medicineName,
              text2: ' - $dosage',
              icon: HugeIcons.strokeRoundedMedicine02,
              isMedicine: true,
            ),
            SizedBox(height: 8.h),
            CustomMedicineRow(
              text1: '$numberOfTimes',
              text2: ' times per day',
              icon: HugeIcons.strokeRoundedClock01,
            ),
          ],
        ),
      ),
    );
  }
}
