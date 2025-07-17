import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/features/home/presentation/managers/test_results/test_results_cubit.dart';
import 'package:healr/features/home/presentation/views/widgets/test_results_view_body.dart';

class TestResultsView extends StatelessWidget {
  const TestResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestResultsCubit(),
      child: const TestResultsViewBody(),
    );
  }
}
