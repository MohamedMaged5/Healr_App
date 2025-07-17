import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_results_state.dart';

class TestResultsCubit extends Cubit<TestResultsState> {
  TestResultsCubit() : super(TestResultsInitial());

  Future<void> loadTestResults() async {
    emit(TestResultsLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(TestResultsInitial());
  }
}
