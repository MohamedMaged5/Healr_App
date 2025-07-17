import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/features/profile/presentation/views/widgets/profile_body.dart';
import 'package:healr/features/profile/presentation/views/widgets/profile_header_section.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeaderSection(),
            SizedBox(height: 48.h),
            const ProfileBody(),
          ],
        ),
      ),
    );
  }
}
