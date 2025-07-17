import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_medical_container.dart';
import 'package:healr/features/profile/presentation/views/widgets/custom_search_text_field.dart';

class MedicalHistoryViewBody extends StatelessWidget {
  const MedicalHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: Column(
                children: [
                  const CustomAppBar(
                    text: 'Medical History',
                  ),
                  SizedBox(height: 32.h),
                  const CustomSearchTextField(),
                  SizedBox(height: 16.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                  SizedBox(height: 24.h),
                  const CustomMedicalContainer(),
                ],
              )),
        ),
      ),
    );
  }
}
