import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/newpass_repo.dart';

part 'newpass_state.dart';

class NewpassCubit extends Cubit<NewpassState> {
  NewpassCubit(this.newpassRepo) : super(NewpassInitial());
  final NewpassRepo newpassRepo;
  Future<void> newpassUser(String password, String confirmPassword) async {
    emit(NewpassLoading());

    var result = await newpassRepo.newpass(password, confirmPassword);
    result.fold(
      (failure) {
        emit(NewpassFailure(failure.errMessage));
      },
      (user) {
        emit(NewpassSuccess(user));
      },
    );
  }
}
