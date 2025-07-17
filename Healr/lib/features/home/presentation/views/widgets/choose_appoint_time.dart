import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/views/widgets/appoint_time_item.dart';

class ChooseAppointTime extends StatelessWidget {
  const ChooseAppointTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Time",
            style: Styles.textStyle20.copyWith(
              fontWeight: FontWeight.w600,
            )),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 44.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const AppointTimeItem(
                index: 0,
                text: "09:00 AM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 1,
                text: "10:00 AM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 3,
                text: "11:00 AM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 5,
                text: "12:00 PM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 6,
                text: "01:00 PM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 8,
                text: "02:00 PM",
              ),
              SizedBox(
                width: 8.w,
              ),
              const AppointTimeItem(
                index: 9,
                text: "03:00 PM",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
