import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'approvals_state.dart';

class ApprovalsCubit extends Cubit<ApprovalsState> {
  ApprovalsCubit() : super(ApprovalsInitial());

  Future<void> loadApprovals() async {
    emit(ApprovalsLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(ApprovalsInitial());
  }
}
