import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/features/notification/ui/views/widgets/custom_notification_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationContainerSkeletonizer extends StatelessWidget {
  const NotificationContainerSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Column(
          children: [
            const CustomNotificationAppBar(
              isNotificationfound: false,
            ),
            SizedBox(height: 32.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 216, 216, 216),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circle Avatar (skeleton)
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Texts (skeleton)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 18.h,
                            width: 150.w,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 14.h,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            height: 14.h,
                            width: 120.w,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
