part of 'get_doctors_cubit.dart';

sealed class GetDoctorsState extends Equatable {
  const GetDoctorsState();

  @override
  List<Object> get props => [];
}

final class GetDoctorsInitial extends GetDoctorsState {}

final class GetDoctorsLoading extends GetDoctorsState {}

final class GetDoctorsSuccess extends GetDoctorsState {
  final AllDoctorsModel user;

  const GetDoctorsSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class GetDoctorsFailure extends GetDoctorsState {
  final String errMessage;

  const GetDoctorsFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
