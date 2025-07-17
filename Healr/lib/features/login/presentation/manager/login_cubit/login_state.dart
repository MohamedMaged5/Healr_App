part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginStateInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class LoginFailure extends LoginState {
  final String errMessage;

  const LoginFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
