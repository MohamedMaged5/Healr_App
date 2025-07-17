part of 'test_results_cubit.dart';

sealed class TestResultsState extends Equatable {
  const TestResultsState();

  @override
  List<Object> get props => [];
}

final class TestResultsInitial extends TestResultsState {}

final class TestResultsLoading extends TestResultsState {}
