part of 'appointment_cubit.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentSuccess extends AppointmentState {
  final AppointDetailsModel appointDetails;

  const AppointmentSuccess(this.appointDetails);

  @override
  List<Object> get props => [appointDetails];
}

final class AppointmentFailure extends AppointmentState {
  final String errorMessage;

  const AppointmentFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AppointmentCancelSuccess extends AppointmentState {}

final class AppointmentCancelFailure extends AppointmentState {
  final String errorMessage;

  const AppointmentCancelFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AppointmentCancelLoading extends AppointmentState {}
