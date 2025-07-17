import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_notification_app_bar.dart';

class NoNotificationView extends StatelessWidget {
  const NoNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomNotificationAppBar(
                          isNotificationfound: false),
                      const Spacer(
                        flex: 1,
                      ),
                      SvgPicture.asset(
                        'assets/images/no_notification.svg',
                        width: 205.w,
                        height: 205.h,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No new notifications right now.',
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff1A1A1A),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        textAlign: TextAlign.center,
                        'You’re all caught up! We’ll notify you when there’s something new.',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff666666),
                        ),
                      ),
                      const Spacer(), // لو عايزها تتمدد وتتمركز
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
