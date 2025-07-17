import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:healr/features/home/presentation/managers/reviews_cubit/reviews_cubit.dart';

class ReviewBottomSheet extends StatefulWidget {
  final ReviewsCubit reviewsCubit;
  final GetDoctorsCubit getDoctorsCubit;
  final String? doctorId;
  const ReviewBottomSheet(
      {super.key,
      required this.reviewsCubit,
      this.doctorId,
      required this.getDoctorsCubit});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController reviewTextController = TextEditingController();
  double rating = 0;

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewsCubit, ReviewsState>(
        bloc: widget.reviewsCubit,
        listener: (context, state) {
          if (state is ReviewsCreateSuccess) {
            // Refresh the doctors list when review is successfully created
            widget.getDoctorsCubit.allDoctors();
            Navigator.pop(context);
          }
          if (state is ReviewsCreateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to create review: ${state.errorMessage}"),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h, left: 10.h),
                        child: SvgPicture.asset(
                          "assets/images/arrow_back_icon.svg",
                          width: 20.w,
                          height: 20.h,
                          color: const Color(0xff1a1a1a),
                        ),
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      "Rate Your Visit!",
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 35.r,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {
                          rating = value;
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Tell Us What Went Well (Optional).",
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 200.h,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: reviewTextController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: "Share your thoughts...",
                          hintStyle: Styles.textStyle14.copyWith(
                            color: Colors.grey[500],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc), width: 1.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc), width: 1.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                                BorderSide(color: kSecondaryColor, width: 1.w),
                          ),
                          contentPadding: EdgeInsets.all(16.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlocBuilder<ReviewsCubit, ReviewsState>(
                      bloc: widget.reviewsCubit,
                      builder: (context, state) {
                        return CustomButton(
                          padding: 0,
                          text: state is ReviewsCreating
                              ? "Submitting..."
                              : "Submit Review",
                          onPressed: state is ReviewsCreating
                              ? null
                              : () {
                                  if (rating == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please select a rating before submitting."),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  widget.reviewsCubit.createReview(
                                      reviewTextController.text,
                                      rating.toInt(),
                                      widget.doctorId!);
                                },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
