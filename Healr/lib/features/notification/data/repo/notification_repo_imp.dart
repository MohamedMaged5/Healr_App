import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/data/models/notification_model.dart';
import 'package:healr/features/notification/data/repo/notification_repo.dart';

class NotificationRepoImp implements NotificationRepo {
  final ApiService apiService;
  NotificationRepoImp(this.apiService);

  @override
  Future<Either<Failure, List<MedicineModel>>> getMedicine() async {
    try {
      final response = await apiService.get(
        endPoint: 'medicine/getMyMedicine',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final List<dynamic> data = response['data'];
      final List<MedicineModel> medicineList =
          data.map((e) => MedicineModel.fromJson(e)).toList();

      return Right(medicineList);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedicine(String medicineId) async {
    try {
      final response = await apiService.deletee(
        endPoint: 'medicine/delete/$medicineId',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
  try {
    final response = await apiService.get(
      endPoint: 'notification',
    );

    if (response.containsKey('status') && response['status'] == 'error') {
      return Left(ServerFailure(response['message']));
    }

    final List<dynamic> data = response['data'];
    final notifications = data.map((e) => NotificationModel.fromJson(e)).toList();

    return Right(notifications);
  } on ServerFailure catch (e) {
    return Left(e);
  } catch (e) {
    return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
  }
}

}
