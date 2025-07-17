import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_medicine_row.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomMedicineDetailsContainer extends StatefulWidget {
  const CustomMedicineDetailsContainer({
    super.key,
    required this.medicineName,
    required this.dosage,
    required this.numberOfTimes,
  });

  final String medicineName;
  final String dosage;
  final int numberOfTimes;

  @override
  State<CustomMedicineDetailsContainer> createState() =>
      CustomMedicineDetailsContainerState();
}

class CustomMedicineDetailsContainerState
    extends State<CustomMedicineDetailsContainer> {
  late List<TimeOfDay> selectedTimes;

  List<TimeOfDay> get getTimes => selectedTimes;

  @override
  void initState() {
    super.initState();
    selectedTimes = List.generate(
      widget.numberOfTimes,
      (index) => TimeOfDay(hour: 9 + index * 2, minute: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xffEFF6FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                CustomMedicineRow(
                  text1: widget.medicineName,
                  text2: ' - ${widget.dosage}',
                  icon: HugeIcons.strokeRoundedMedicine02,
                  isMedicine: true,
                ),
                SizedBox(height: 8.h),
                CustomMedicineRow(
                  text1: '${widget.numberOfTimes}',
                  text2: ' times per day',
                  icon: HugeIcons.strokeRoundedClock01,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Suggested Timings',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Set your preferred timings for taking this medicine to ensure you never miss a dose.',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1A1A1A),
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: List.generate(
              widget.numberOfTimes,
              (index) => SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dose ${index + 1}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CupertinoTimePickerButton(
                      use24hFormat: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      initialTime: selectedTimes[index],
                      onTimeChanged: (time) {
                        setState(() {
                          selectedTimes[index] = time;
                        });
                        SharedPrefCache.saveCache(
                          key: 'medicineTime${index + 1}',
                          value: time.format(context),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
