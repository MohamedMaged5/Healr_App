import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/app_router.dart';
import 'package:healr/features/home/presentation/views/widgets/custom_container.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'img': 'assets/images/bone.svg',
        'title': 'Orthopedics',
        'onTap': () {
          // Set the search query in constants
          pendingSearchQuery = "Orthopedics";
          // Navigate directly to search view
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
      {
        'img': 'assets/images/Pulmonology.svg',
        'title': 'Pulmonology',
        'onTap': () {
          pendingSearchQuery = "Pulmonology";
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
      {
        'img': 'assets/images/Dermatology.svg',
        'title': 'Dermatology',
        'onTap': () {
          pendingSearchQuery = "Dermatology";
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
      {
        'img': 'assets/images/dental.svg',
        'title': 'Dental Care',
        'onTap': () {
          pendingSearchQuery = "dental";
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
      {
        'img': 'assets/images/mental.svg',
        'title': 'Mental Health',
        'onTap': () {
          pendingSearchQuery = "Psychiatry";
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
      {
        'img': 'assets/images/eye.svg',
        'title': 'Eye Care',
        'onTap': () {
          pendingSearchQuery = "Ophthalmology";
          GoRouter.of(context).push(AppRouter.kSearchview);
        },
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.only(top: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.4,
      ),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data[index];
        return CustomContainer(
          imgUrl: item['img'],
          title: item['title'],
          onTap: item['onTap'],
        );
      },
    );
  }
}
