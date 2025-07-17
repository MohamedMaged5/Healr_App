import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/home/data/models/all_doctors_model/all_doctors_model.dart';

abstract class GetDoctorsRepo {
  Future<Either<Failure, AllDoctorsModel>> getDoctors();
}
