import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/profile/data/model/health_insurance_model.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo_imp.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';
import 'package:healr/features/profile/presentation/views/no_health_insurance_view.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_insurance_row.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HealthInsuranceViewBody extends StatelessWidget {
  const HealthInsuranceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HealthInsuranceCubit(getIt.get<HealthInsuranceRepoImp>())
            ..getHealthInsurance(),
      child: BlocListener<HealthInsuranceCubit, HealthInsuranceState>(
        listener: (context, state) {
          if (state is HealthInsuranceAdded ||
              state is HealthInsuranceDeleted) {
            context.read<HealthInsuranceCubit>().getHealthInsurance();
          }
        },
        child: BlocBuilder<HealthInsuranceCubit, HealthInsuranceState>(
          builder: (context, state) {
            if (state is HealthInsuranceLoading) {
              return Skeletonizer(child: buildInsuranceCardPlaceHolder());
            }

            if (state is HealthInsuranceFetched) {
              return buildInsuranceCard(state.healthInsurance!, context);
            }

            if (state is HealthInsuranceEmpty) {
              return const NoHealthInsuranceView();
            }

            if (state is HealthInsuranceError ||
                state is HealthInsuranceDeleteError) {
              return const NoHealthInsuranceView();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

Widget buildInsuranceCard(
    HealthInsuranceModel healthInsurance, BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(text: 'Health Insurance'),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE6E6E6).withOpacity(0.7),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/insurance.png',
                          width: 80.w,
                          height: 70.h,
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Insurance Provider:',
                                style: Styles.textStyle14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF666666),
                                )),
                            Text(
                              'The General Authority for\n Health Insurance in Egypt',
                              style: Styles.textStyle16.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CustomInsuranceRow(
                      text1: 'Health unit',
                      text2: healthInsurance.healthUnit,
                    ),
                    SizedBox(height: 16.h),
                    CustomInsuranceRow(
                      text1: 'File number',
                      text2: healthInsurance.fileNumber,
                    ),
                    SizedBox(height: 16.h),
                    CustomInsuranceRow(
                      text1: 'Family Head',
                      text2: healthInsurance.headFamily
                          .split(' ')
                          .take(2)
                          .join(' '),
                    ),
                    SizedBox(height: 16.h),
                    CustomInsuranceRow(
                      text1: 'Beneficiary name',
                      text2: healthInsurance.beneficiaryName
                          .split(' ')
                          .take(2)
                          .join(' '),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                text: 'Remove Health Insurance',
                textColor: const Color(0xFFEF4444),
                color: kPrimaryColor,
                borderColor: const Color(0xFFEF4444),
                borderRadius: 16.r,
                padding: 0,
                onPressed: () async {
                  await context
                      .read<HealthInsuranceCubit>()
                      .deleteHealthInsurance();
                  await Future.delayed(const Duration(seconds: 2));
                  await GoRouter.of(context)
                      .pushReplacement(AppRouter.kHomeView);
                },
              ),
              SizedBox(height: 32.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    HugeIcons.strokeRoundedInformationCircle,
                    size: 24.sp,
                    color: const Color(0xFF3A95D2),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'This card will be applied automatically to all\n future booking requests .',
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildInsuranceCardPlaceHolder() {
  return Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(text: 'Health Insurance'),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE6E6E6).withOpacity(0.7),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80.w,
                          height: 70.h,
                          color: Colors.grey[300],
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 160.w,
                              height: 16.h,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: 180.w,
                              height: 20.h,
                              color: Colors.grey[300],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),
                    ...List.generate(
                        4,
                        (index) => Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 14.h,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    width: double.infinity,
                                    height: 16.h,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            )),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    HugeIcons.strokeRoundedInformationCircle,
                    size: 24.sp,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 240.w,
                    height: 40.h,
                    color: Colors.grey[300],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
