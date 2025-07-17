import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/custom_text_span.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/views/widgets/view_appoint_details_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WaitingpeopleSkeletonizer extends StatelessWidget {
  const WaitingpeopleSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: DottedBorder(
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
                        'Ahead of you in line:',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '5 people waiting',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextSpan(
                        text1:
                            'The waiting time for your appointment\n is about ',
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: Size(100.w, 40.h),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
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
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  height: 100.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
