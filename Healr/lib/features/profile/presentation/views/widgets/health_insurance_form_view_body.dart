import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo_imp.dart';
import 'package:healr/features/profile/presentation/manager/health_insurance_cubit/cubit/health_insurance_cubit.dart';
import 'package:healr/features/profile/presentation/views/widgets/health_insurance_text_field.dart';

class HealthInsuranceFormViewBody extends StatefulWidget {
  const HealthInsuranceFormViewBody({super.key});

  @override
  State<HealthInsuranceFormViewBody> createState() =>
      _HealthInsuranceFormViewBodyState();
}

class _HealthInsuranceFormViewBodyState
    extends State<HealthInsuranceFormViewBody> {
  final TextEditingController headFamilyController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();
  final TextEditingController healthUnitController = TextEditingController();
  final TextEditingController fileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;
  @override
  void dispose() {
    headFamilyController.dispose();
    beneficiaryNameController.dispose();
    healthUnitController.dispose();
    fileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HealthInsuranceCubit(getIt.get<HealthInsuranceRepoImp>()),
      child: BlocConsumer<HealthInsuranceCubit, HealthInsuranceState>(
          listener: (context, state) {
        if (state is HealthInsuranceAdded) {
          GoRouter.of(context)
              .pushReplacement(AppRouter.kHealthInsuranceFormDoneView);
        } else if (state is HealthInsuranceError) {
          setState(() {
            errorMessage = state.message;
          });
        }
      }, builder: (context, state) {
        final isLoading = state is HealthInsuranceLoading;
        final hasError = state is HealthInsuranceError;
        final errorMsg = hasError ? state.message : null;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32.h,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    'assets/images/back-arrow.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: 16.h),
                                child: Image.asset(
                                  'assets/images/insurance.png',
                                  width: 80.w,
                                  height: 70.h,
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            child: Text(
                              'Health Insurance Submission',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HealthInsuranceTextField(
                              hintText: 'Enter the head of the family name',
                              labelText: 'Head of the family',
                              controller: headFamilyController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the head of the family name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            HealthInsuranceTextField(
                              hintText: 'Enter beneficiary name',
                              labelText: 'Beneficiary name',
                              controller: beneficiaryNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the beneficiary name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            HealthInsuranceTextField(
                              hintText: 'Enter health unit name',
                              labelText: 'Health unit',
                              controller: healthUnitController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the health unit name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            HealthInsuranceTextField(
                              hintText: 'Enter File number',
                              labelText: 'File number',
                              controller: fileNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the file number';
                                }
                                return null;
                              },
                            ),
                            if (errorMsg != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                child: Text(
                                  errorMsg,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      text: isLoading ? 'Submitting...' : 'Submit',
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<HealthInsuranceCubit>(context)
                                    .addHealthInsurance(
                                  headFamily: headFamilyController.text.trim(),
                                  beneficiaryName:
                                      beneficiaryNameController.text.trim(),
                                  healthUnit: healthUnitController.text.trim(),
                                  fileNumber: fileNumberController.text.trim(),
                                );
                              }
                            },
                      color: const Color(0xFF3A95D2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
