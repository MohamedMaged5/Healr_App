import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/search/data/models/doctor_name_model/doctor_name_model.dart';
import 'package:healr/features/search/data/models/doctor_specialization_model/doctor_specialization_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, DoctorSpecializationModel>> specializationSearch(
      String specialization);
  Future<Either<Failure, DoctorNameModel>> nameSearch(String name);
}
