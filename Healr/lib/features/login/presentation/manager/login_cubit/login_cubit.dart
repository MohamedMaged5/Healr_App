import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/login/data/model/user_model.dart';
import 'package:healr/features/login/data/repos/login_repo.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo_imp.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginStateInitial());

  final LoginRepo loginRepo;

  Future<void> loginUser(String nationalID, String password) async {
    emit(LoginLoading());

    var result = await loginRepo.loginUser(nationalID, password);

    result.fold(
      (failure) {
        emit(LoginFailure(failure.errMessage));
      },
      (user) async {
        final profileResult = await getIt<ProfileRepoImp>().getProfile();

        profileResult.fold(
          (failure) {
            emit(LoginFailure(failure.errMessage));
          },
          (profile) {
            emit(LoginSuccess(user));
          },
        );
      },
    );
  }

  Future<void> loginUserWithEmail(String email, String password) async {
    emit(LoginLoading());

    var result = await loginRepo.loginWithEmail(email, password);

    result.fold(
      (failure) {
        emit(LoginFailure(failure.errMessage));
      },
      (user) async {
        final profileResult = await getIt<ProfileRepoImp>().getProfile();

        profileResult.fold(
          (failure) {
            emit(LoginFailure(failure.errMessage));
          },
          (profile) {
            emit(LoginSuccess(user));
          },
        );
      },
    );
  }
}
