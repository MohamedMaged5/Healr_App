import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_day_state.dart';

class SelectedDayCubit extends Cubit<SelectedDayState> {
  SelectedDayCubit() : super(const SelectedDay());
  int? selectedIndexDay;

  selectDay(int? index) {
    emit(SelectedLoadingDay());
    selectedIndexDay = index;
    emit(SelectedDay(selectedIndexDay: selectedIndexDay));
  }
}
