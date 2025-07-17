import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/home/data/models/appoint_details_model/appoint_details_model.dart';
import 'package:healr/features/home/data/repos/appoint_repo.dart';

class AppointRepoImp implements AppointRepo {
  final ApiService apiService;
  AppointRepoImp(this.apiService);
  @override
  Future<Either<Failure, AppointDetailsModel>> createAppointment(
      String doctorID, String day, String time) async {
    try {
      final token = SharedPrefCache.getCache(key: 'token');

      final response = await apiService.post(
        endPoint: 'appointment/createAppointment',
        body: {
          "day": day,
          "time": time,
          "bookingFor": "self",
          "gender": "",
          "relation": "",
          "problem": "will be discussed during the appointment",
          "doctorId": doctorID
        },
        token: token.isNotEmpty ? 'Bearer $token' : '',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }
      final user = AppointDetailsModel.fromJson(response);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> cancelAppointment(
      String appointmentID) async {
    try {
      final token = SharedPrefCache.getCache(key: 'token');

      final response = await apiService.delete(
        endPoint: 'appointment/cancelAppointment',
        body: {"appointmentId": appointmentID},
        token: token.isNotEmpty ? 'Bearer $token' : '',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
