part of 'newpass_cubit.dart';

sealed class NewpassState extends Equatable {
  const NewpassState();

  @override
  List<Object> get props => [];
}

final class NewpassInitial extends NewpassState {}

final class NewpassLoading extends NewpassState {}

final class NewpassSuccess extends NewpassState {
  final ForgetPassModel user;

  const NewpassSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class NewpassFailure extends NewpassState {
  final String errMessage;

  const NewpassFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
