import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_time_state.dart';

class SelectedTimeCubit extends Cubit<SelectedTimeState> {
  SelectedTimeCubit() : super(const SelectedTimeInitial());
  int? selectedIndexTime;
  selectTime(int? index) {
    emit(SelectedTimeLoading());
    selectedIndexTime = index;
    emit(SelectedTimeInitial(selectedIndexTime: selectedIndexTime));
  }
}
