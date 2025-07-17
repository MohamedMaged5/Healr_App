import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/review.dart';

class ReviewCard extends StatelessWidget {
  final Review? review;
  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: review?.userImage != null &&
                        review!.userImage!.isNotEmpty
                    ? NetworkImage(review!.userImage!)
                    : const AssetImage('assets/images/doctor_prof_image.png')
                        as ImageProvider,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review?.userName ?? "Unknown User",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          review?.rating?.toString() ?? "0",
                          style: Styles.textStyle12,
                        ),
                        SizedBox(width: 0.5.w),
                        Flexible(
                          child: RatingBarIndicator(
                            itemSize: 16.r,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            rating: review?.rating?.toDouble() ?? 0.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xffFFB800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  Text(
                    review?.createdAt != null
                        ? DateFormat('yyyy-MM-dd').format(review!.createdAt!)
                        : "2025-7-2",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.textStyle12.copyWith(
                      color: const Color(0xff666666),
                    ),
                  ),
                  // SizedBox(height: 0.h),
                  // Text(
                  //   review?.createdAt != null
                  //       ? DateFormat('HH:mm').format(review!.createdAt!)
                  //       : "10:44",
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  //   style: Styles.textStyle12.copyWith(
                  //     color: const Color(0xff666666),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            review?.reviewText == null || review?.reviewText == ''
                ? ""
                : review?.reviewText ?? "",
            style: Styles.textStyle14.copyWith(
              color: const Color(0xff1a1a1a),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffCCCCCC),
          ),
        ],
      ),
    );
  }
}
