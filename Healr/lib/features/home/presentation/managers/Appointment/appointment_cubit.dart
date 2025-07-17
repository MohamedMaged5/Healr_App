import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/data/repos/appoint_repo.dart';
import 'package:healr/features/notification/ui/views/widgets/local_notification.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this.appointRepo) : super(AppointmentInitial());
  final AppointRepo appointRepo;

  Future<void> createAppointment(
    String doctorID,
    String day,
    String time,
    String doctorName,
  ) async {
    emit(AppointmentLoading());
    var result = await appointRepo.createAppointment(doctorID, day, time);
    LocalNotification.showInstantNotification(
      id: 1,
      title: 'Appointment Created',
      body:
          'Your appointment has been successfully created with Dr. $doctorName on $day at $time.',
    );
    result.fold(
      (failure) => emit(AppointmentFailure(failure.errMessage)),
      (success) {
        emit(AppointmentSuccess(success));
      },
    );
  }

  Future<void> cancelAppointment(String appointmentID) async {
    emit(AppointmentCancelLoading());
    var result = await appointRepo.cancelAppointment(appointmentID);
    LocalNotification.showInstantNotification(
      id: 2,
      title: 'Appointment Cancelled',
      body: 'Your appointment has been successfully cancelled.',
    );
    result.fold(
      (failure) => emit(AppointmentCancelFailure(failure.errMessage)),
      (success) {
        emit(AppointmentCancelSuccess());
      },
    );
  }
}
