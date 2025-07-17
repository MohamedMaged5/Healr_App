part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserModel user;

  const SignUpSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class SignUpFailure extends SignUpState {
  final String errMessage;

  const SignUpFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
