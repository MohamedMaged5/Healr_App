part of 'selected_time_cubit.dart';

sealed class SelectedTimeState extends Equatable {
  const SelectedTimeState();

  @override
  List<Object> get props => [];
}

final class SelectedTimeInitial extends SelectedTimeState {
  final int? selectedIndexTime;
  const SelectedTimeInitial({this.selectedIndexTime});
}

final class SelectedTimeLoading extends SelectedTimeState {}
