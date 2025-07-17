import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/search/data/models/doctor_name_model/doctor_name_model.dart';
import 'package:healr/features/search/data/models/doctor_specialization_model/doctor_specialization_model.dart';
import 'package:healr/features/search/data/repos/search_repo.dart';

class SearchRepoImp implements SearchRepo {
  final ApiService apiService;
  SearchRepoImp(this.apiService);

  @override
  Future<Either<Failure, DoctorNameModel>> nameSearch(String name) async {
    try {
      final response = await apiService.get(
        endPoint: 'doctor/searchByName/name?name=$name',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final user = DoctorNameModel.fromJson(response);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, DoctorSpecializationModel>> specializationSearch(
      String specialization) async {
    try {
      final response = await apiService.get(
        endPoint:
            'doctor/searchBySpecialization/specialization?specialization=$specialization',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final user = DoctorSpecializationModel.fromJson(response);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
