part of 'verification_cubit.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationLoading extends VerificationState {}

final class VerificationSuccess extends VerificationState {
  final ForgetPassModel user;

  const VerificationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class VerificationFailure extends VerificationState {
  final String errMessage;

  const VerificationFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
