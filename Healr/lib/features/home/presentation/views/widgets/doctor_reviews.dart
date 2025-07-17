import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/data/models/all_doctors_model/review.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/review_card.dart';
import 'package:healr/features/home/presentation/views/widgets/reviews_skeletonizer.dart';

class DoctorReviews extends StatefulWidget {
  final List<Review>? review;
  final String? doctorId;
  const DoctorReviews({super.key, required this.review, this.doctorId});

  @override
  State<DoctorReviews> createState() => _DoctorReviewsState();
}

class _DoctorReviewsState extends State<DoctorReviews> {
  @override
  void initState() {
    BlocProvider.of<GetDoctorsCubit>(context).allDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews",
          style: Styles.textStyle20.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        const Divider(
          thickness: 1,
          color: Color(0xffCCCCCC),
        ),
        SizedBox(
          height: 4.h,
        ),
        BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
          builder: (context, state) {
            if (state is GetDoctorsLoading) {
              return Center(
                child: Column(
                  children: [
                    ReviewsSkeletonizer(
                      review: widget.review?.firstOrNull,
                    )
                  ],
                ),
              );
            } else if (state is GetDoctorsFailure) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 6.h),
                    Text(
                      "Failed to load reviews",
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              );
            } else if (state is GetDoctorsSuccess) {
              // Get the current reviews from the state - find the specific doctor's reviews
              List<Review>? currentReviews;

              // If we have a doctor ID, find the doctor's reviews from the updated state
              if (widget.doctorId != null && state.user.data != null) {
                final doctor = state.user.data!
                    .where((doc) => doc.id == widget.doctorId)
                    .firstOrNull;
                if (doctor != null) {
                  currentReviews = doctor.reviews;
                }
              }

              // Fallback to widget.review if no doctor ID or doctor not found
              currentReviews ??= widget.review;

              // Check if reviews are available
              if (currentReviews == null || currentReviews.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 6.h),
                      Text(
                        "No reviews available",
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentReviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(
                    review: currentReviews![index],
                  );
                },
              );
            }

            return const SizedBox();
          },
        )
      ],
    );
  }
}
