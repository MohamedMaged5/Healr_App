import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/widgets/doctor_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchSkeletonizer extends StatelessWidget {
  const SearchSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: const DoctorCard(
              doctorName: "Dr. John Doe",
              doctorSpecialty: "Cardiology",
              doctorImg: null, // No image for skeleton loading
              rating: 4.5,
              label: "View Doctor",
            ),
          );
        },
      ),
    );
  }
}
