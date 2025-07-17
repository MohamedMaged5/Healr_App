import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/home/presentation/views/widgets/inusrance_home_skeleton.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HealthInsuranceSection extends StatefulWidget {
  const HealthInsuranceSection({super.key});

  @override
  State<HealthInsuranceSection> createState() => _HealthInsuranceSectionState();
}

class _HealthInsuranceSectionState extends State<HealthInsuranceSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthInsuranceCubit, HealthInsuranceState>(
      builder: (context, state) {
        if (state is HealthInsuranceLoading) {
          return Skeletonizer(
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
              ),
              enabled: true,
              containersColor: const Color(0xff1C567D),
              child: const InusranceHomeSkeleton());
        }
        if (state is HealthInsuranceFetched) {
          return GestureDetector(
              onTap: () async {
                await GoRouter.of(context).push(AppRouter.kHealthInsuranceView);
              },
              child: Container(
                height: 100.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 8.h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff1C567D),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You have an active health insurance',
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffF8F8F8),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your Can See your health insurance details and\n manage it from here.',
                          style: Styles.textStyle12.copyWith(
                            fontWeight: FontWeight.w300,
                            color: const Color(0xffE6E6E6),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      HugeIcons.strokeRoundedArrowRight01,
                      color: const Color(0xffF8F8F8),
                      size: 24.r,
                    ),
                  ],
                ),
              ));
        } else if (state is HealthInsuranceEmpty ||
            state is HealthInsuranceError) {
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kHealthInsuranceView);
            },
            child: Container(
              height: 78.h,
              padding: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 8.h,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff1C567D),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add your health insurance',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffF8F8F8),
                        ),
                      ),
                      Text(
                        'Book a doctor and save consultation fees with\n insurance.',
                        style: Styles.textStyle12.copyWith(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xffE6E6E6),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/add-circle.svg',
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
