import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/data/models/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<MedicineModel>>> getMedicine();
  Future<Either<Failure, void>> deleteMedicine(String medicineId);
  Future<Either<Failure, List<NotificationModel>>> getNotifications();

}
