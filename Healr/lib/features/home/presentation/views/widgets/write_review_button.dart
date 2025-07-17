import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/managers/get_doctors/get_doctors_cubit.dart';
import 'package:healr/features/home/presentation/managers/reviews_cubit/reviews_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/review_bottom_sheet.dart';

class WriteReviewButton extends StatelessWidget {
  const WriteReviewButton({
    super.key,
    this.doctorId,
  });
  final String? doctorId;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final reviewsCubit = BlocProvider.of<ReviewsCubit>(context);
        final getDoctorsCubit = BlocProvider.of<GetDoctorsCubit>(context);
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (modalContext) {
              return ReviewBottomSheet(
                doctorId: doctorId,
                reviewsCubit: reviewsCubit,
                getDoctorsCubit: getDoctorsCubit,
              );
            });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(130.w, 45.h),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: kSecondaryColor,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      ),
      child: Text(
        "Write Review",
        style: Styles.textStyle20.copyWith(
          fontWeight: FontWeight.w600,
          color: kSecondaryColor,
        ),
      ),
    );
  }
}
