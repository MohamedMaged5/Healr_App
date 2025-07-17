import 'package:flutter/material.dart';
import 'package:healr/features/home/presentation/views/widgets/results_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestResultSkeleton extends StatelessWidget {
  const TestResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: const ResultsListView());
  }
}
