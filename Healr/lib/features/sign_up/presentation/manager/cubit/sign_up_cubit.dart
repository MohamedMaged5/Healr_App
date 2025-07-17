import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/login/data/model/user_model.dart';
import 'package:healr/features/sign_up/data/repos/sign_up_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  final SignUpRepo signUpRepo;

  Future<void> signUpUser(Map<String, dynamic> signUpData) async {
    emit(SignUpLoading());

    var result = await signUpRepo.signUpUser(signUpData);

    result.fold(
      (failure) {
        emit(SignUpFailure(failure.errMessage));
      },
      (user) {
        emit(SignUpSuccess(user));
      },
    );
  }
}
