import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/profile/data/model/health_insurance_model.dart';

abstract class HealthInsuranceRepo {
  Future<Either<Failure, HealthInsuranceModel>> addHealthInsurance(
    String headFamily,
    String beneficiaryName,
    String healthUnit,
    String fileNumber,
  );
  Future<Either<Failure, HealthInsuranceModel?>> getHealthInsurance();
  Future<Either<Failure, dynamic>> deleteHealthInsurance();
}
