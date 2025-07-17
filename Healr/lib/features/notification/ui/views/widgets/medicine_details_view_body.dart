import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_medicine_details_container.dart';
import 'package:healr/features/notification/ui/views/widgets/local_notification.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';

class MedicineDetailsViewBody extends StatefulWidget {
  const MedicineDetailsViewBody({super.key, required this.meds});

  final List<MedicineModel> meds;

  @override
  State<MedicineDetailsViewBody> createState() =>
      _MedicineDetailsViewBodyState();
}

class _MedicineDetailsViewBodyState extends State<MedicineDetailsViewBody> {
  late List<GlobalKey<CustomMedicineDetailsContainerState>> keys;

  @override
  void initState() {
    super.initState();
    keys = List.generate(
      widget.meds.length,
      (_) => GlobalKey<CustomMedicineDetailsContainerState>(),
    );
  }

  void saveAllNotifications() {
    for (int i = 0; i < keys.length; i++) {
      final times = keys[i].currentState?.getTimes;
      if (times == null) continue;

      final medicine = widget.meds[i];

      for (int j = 0; j < times.length; j++) {
        final time = times[j];

        // احسب أول إشعار مقارنة بالوقت الحالي
        final now = TimeOfDay.now();
        final delayInMinutes =
            ((time.hour - now.hour) * 60 + (time.minute - now.minute)) % 1440;
        final delay = Duration(minutes: delayInMinutes);

        LocalNotification.scheduleCustomRepeatingNotification(
          id: i * 100 + j,
          title: 'موعد الدواء: ${medicine.name}',
          body: 'الجرعة: ${medicine.dosage}',
          payload: 'med:${medicine.name}',
          initialDelay: delay,
          interval: const Duration(hours: 24),
          totalDays: medicine.durationInDays,
        );
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم جدولة كل الإشعارات بنجاح'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: const CustomAppBar(text: 'Add Reminder'),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'Medicine Details',
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            SliverList.separated(
              itemCount: widget.meds.length,
              itemBuilder: (context, index) {
                return CustomMedicineDetailsContainer(
                  key: keys[index],
                  medicineName: widget.meds[index].name,
                  dosage: widget.meds[index].dosage,
                  numberOfTimes: widget.meds[index].numberOfTimes,
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CustomButton(
                  text: 'Save',
                  onPressed: saveAllNotifications,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
