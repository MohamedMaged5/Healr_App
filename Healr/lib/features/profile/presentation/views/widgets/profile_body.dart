import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:healr/features/profile/presentation/views/widgets/profile_custom_row.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileCustomRow(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kYourProfileView);
          },
          icon: HugeIcons.strokeRoundedUser,
          text: "Your Profile",
        ),
        SizedBox(height: 36.h),
        ProfileCustomRow(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kHealthInsuranceView);
          },
          icon: HugeIcons.strokeRoundedIdentityCard,
          text: "Health Insurance",
        ),
        SizedBox(height: 36.h),
        ProfileCustomRow(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kHelpCenterView);
          },
          icon: HugeIcons.strokeRoundedHelpCircle,
          text: "Help Center",
        ),
        SizedBox(height: 36.h),
        ProfileCustomRow(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kPrivacyPolicyView);
          },
          icon: HugeIcons.strokeRoundedCircleLock01,
          text: "Privacy Policy",
        ),
        SizedBox(height: 36.h),
        ProfileCustomRow(
          onTap: () {
            showLogoutSheet(
              context,
            );
          },
          textColor: const Color(0xffD80000),
          color: const Color(0xffD80000),
          icon: HugeIcons.strokeRoundedLogout03,
          text: "Log Out",
        ),
      ],
    );
  }
}
