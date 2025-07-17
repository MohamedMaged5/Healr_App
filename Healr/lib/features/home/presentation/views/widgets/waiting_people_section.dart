import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/custom_text_span.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/datum.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/presentation/managers/booking/booking_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/view_appoint_details_button.dart';

class WaitingPeopleSection extends StatelessWidget {
  final Datum? data;
  final AppointDetailsModel? appointDetails;
  const WaitingPeopleSection({super.key, this.data, this.appointDetails});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(28),
      dashPattern: const [16, 16],
      strokeWidth: 1,
      color: const Color(0xff1C567D),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max number of appointment in one hour is 4',
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextSpan(
                    text1:
                        'The maximum waiting time for your appointment time is about ',
                    text2: 'one hour.',
                    text1Style: Styles.textStyle12.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    text2Style: Styles.textStyle12.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await BlocProvider.of<BookingCubit>(context)
                                .cancelAppointment();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(100.w, 40.h),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                color: kSecondaryColor,
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ViewAppointDetailsButton(
                          text: "Details",
                          onPressed: () {
                            GoRouter.of(context).push(
                              AppRouter.kAppointDetailsView,
                              extra: {
                                'data': data,
                                'appointDetails': appointDetails,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            SvgPicture.asset(
              'assets/images/waiting_person.svg',
              height: 100.h,
              width: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
