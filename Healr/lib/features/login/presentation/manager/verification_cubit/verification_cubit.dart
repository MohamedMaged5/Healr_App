import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/verification_repo.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this.verificationRepo) : super(VerificationInitial());
  final VerificationRepo verificationRepo;

  Future<void> verifyUser(String code) async {
    emit(VerificationLoading());

    var result = await verificationRepo.verification(code);

    result.fold(
      (failure) {
        emit(VerificationFailure(failure.errMessage));
      },
      (user) {
        emit(VerificationSuccess(user));
      },
    );
  }
}
