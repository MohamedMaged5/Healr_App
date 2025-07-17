import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/forget_pass_repo.dart';

part 'forgetpass_state.dart';

class ForgetPassCubit extends Cubit<ForgetpassState> {
  ForgetPassCubit(this.forgetPassRepo) : super(ForgetpassInitial());

  final ForgetPassRepo forgetPassRepo;

  Future<void> forgetUser(String email) async {
    emit(ForgetPassLoading());

    var result = await forgetPassRepo.forgetpass(email);
    result.fold(
      (failure) {
        emit(ForgetPassFailure(failure.errMessage));
      },
      (user) {
        emit(ForgetPassSuccess(user));
      },
    );
  }
}
