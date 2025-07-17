part of 'forgetpass_cubit.dart';

sealed class ForgetpassState extends Equatable {
  const ForgetpassState();

  @override
  List<Object> get props => [];
}

final class ForgetpassInitial extends ForgetpassState {}

final class ForgetPassLoading extends ForgetpassState {}

final class ForgetPassSuccess extends ForgetpassState {
  final ForgetPassModel user;

  const ForgetPassSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ForgetPassFailure extends ForgetpassState {
  final String errMessage;

  const ForgetPassFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
