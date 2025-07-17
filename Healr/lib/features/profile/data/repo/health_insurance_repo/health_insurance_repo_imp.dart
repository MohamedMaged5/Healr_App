import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/profile/data/model/health_insurance_model.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo.dart';

class HealthInsuranceRepoImp implements HealthInsuranceRepo {
  final ApiService apiService;
  HealthInsuranceRepoImp(this.apiService);

  @override
  Future<Either<Failure, HealthInsuranceModel>> addHealthInsurance(
      String headFamily,
      String beneficiaryName,
      String healthUnit,
      String fileNumber) async {
    try {
      final response = await apiService.post(
        endPoint: 'healthInsurance/createHealthInsurance',
        body: {
          'headFamily': headFamily,
          'beneficiaryName': beneficiaryName,
          'healthUnit': healthUnit,
          'fileNumber': fileNumber,
        },
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final healthInsurance = HealthInsuranceModel.fromJson(response);
      return Right(healthInsurance);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthInsuranceModel>> getHealthInsurance() async {
    try {
      final response = await apiService.get(
          endPoint: 'healthInsurance/getHealthInsuranceByUser');
      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }
      final healthInsurance = HealthInsuranceModel.fromJson(response);
      return Right(healthInsurance);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteHealthInsurance() async {
    try {
      final response = await apiService.deletee(
          endPoint: 'healthInsurance/deleteHealthInsurance');
      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }
      return Right(response['message']);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
