import 'package:flutter/material.dart';
import 'package:healr/features/home/data/models/test_results_model.dart';
import 'package:healr/features/home/presentation/views/widgets/test_results_container.dart';

final List<TestResultModel> dummyTestResults = [
  TestResultModel(
    title: 'Covid-19 Test Results',
    date: 'June 15, 2025',
    result: 'Negative. No viral RNA detected at the time of testing.',
    pdfAssetPath: 'assets/pdfs/covid19_result.pdf',
  ),
  TestResultModel(
    title: 'Blood Test',
    date: 'May 28, 2025',
    result: 'All parameters are within normal range.',
    pdfAssetPath: 'assets/pdfs/blood_test.pdf',
  ),
];

class ResultsListView extends StatelessWidget {
  const ResultsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyTestResults.length,
      itemBuilder: (context, index) {
        return TestResultsContainer(result: dummyTestResults[index]);
      },
    );
  }
}
