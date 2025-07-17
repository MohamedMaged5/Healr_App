import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/views/widgets/icon_statement.dart';

class AppointDetailsContainer extends StatelessWidget {
  const AppointDetailsContainer({
    super.key,
    this.appointDetails,
  });
  final AppointDetailsModel? appointDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xffcccccc),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IconStatement(
              icon: "assets/images/hashtag.svg", label: "Appointment ID"),
          SizedBox(
            height: 4.h,
          ),
          Align(
            alignment: const Alignment(-0.79, 0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  appointDetails?.data?.appointment?.appointmentId.toString() ??
                      "#52",
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff666666),
                  )),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          const IconStatement(icon: "assets/images/clock.svg", label: "Time"),
          SizedBox(
            height: 4.h,
          ),
          Align(
            alignment: const Alignment(-0.7, 0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  "${appointDetails!.data!.appointment!.day}, ${appointDetails!.data!.appointment!.time}.",
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff666666),
                  )),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          const IconStatement(
              icon: "assets/images/hospital-location.svg", label: "Location"),
          SizedBox(
            height: 4.h,
          ),
          Align(
            alignment: const Alignment(-0.6, 0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Ismailia Medical Complex",
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff666666),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
