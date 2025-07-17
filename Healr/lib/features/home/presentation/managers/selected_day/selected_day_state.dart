part of 'selected_day_cubit.dart';

sealed class SelectedDayState extends Equatable {
  const SelectedDayState();

  @override
  List<Object> get props => [];
}

final class SelectedDay extends SelectedDayState {
  final int? selectedIndexDay;
  const SelectedDay({this.selectedIndexDay});
}

final class SelectedLoadingDay extends SelectedDayState {}
