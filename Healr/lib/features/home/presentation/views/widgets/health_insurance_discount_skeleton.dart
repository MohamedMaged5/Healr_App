import 'package:flutter/material.dart';
import 'package:healr/features/home/presentation/views/widgets/details_statement.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HealthInsuranceDiscountSkeleton extends StatelessWidget {
  const HealthInsuranceDiscountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: const DetailsStatement(
          label: "health insurance discount",
          detail: "300 L.E.",
        ));
  }
}
