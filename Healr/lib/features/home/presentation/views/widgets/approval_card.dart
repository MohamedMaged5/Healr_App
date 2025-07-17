import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';

class ApprovalCard extends StatelessWidget {
  final String label;
  final String submittedBy;
  final String submittedDate;
  final String statusWord;
  final Color statusWordIconColor;
  final Color statusContainerColor;
  final IconData statusIcon;
  final String statusStatment;

  const ApprovalCard({
    super.key,
    required this.label,
    required this.submittedBy,
    required this.submittedDate,
    required this.statusWord,
    required this.statusWordIconColor,
    required this.statusContainerColor,
    required this.statusIcon,
    required this.statusStatment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xffCCCCCC),
          width: 1.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Text(
                "Submitted by: ",
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff666666),
                ),
              ),
              Expanded(
                child: Text(
                  submittedBy,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Text(
                "Submitted: ",
                style: Styles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff666666),
                ),
              ),
              Expanded(
                child: Text(
                  submittedDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1A1A1A),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: statusContainerColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      statusIcon,
                      size: 20.sp,
                      color: statusWordIconColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      statusWord,
                      style: Styles.textStyle14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: statusWordIconColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            statusStatment,
            style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500, color: const Color(0xff1A1A1A)),
          )
        ],
      ),
    );
  }
}
