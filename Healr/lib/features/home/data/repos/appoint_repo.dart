import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';

abstract class AppointRepo {
  Future<Either<Failure, AppointDetailsModel>> createAppointment(
    String doctorID,
    String day,
    String time,
  );

  Future<Either<Failure, dynamic>> cancelAppointment(String appointmentID);
}
