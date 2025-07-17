import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/home/data/models/all_doctors_model/all_doctors_model.dart';
import 'package:healr/features/home/data/repos/get_doctors_repo.dart';

class GetDoctorsRepoImp implements GetDoctorsRepo {
  final ApiService apiService;
  GetDoctorsRepoImp(this.apiService);
  @override
  Future<Either<Failure, AllDoctorsModel>> getDoctors() async {
    try {
      final response = await apiService.get(
        endPoint: 'doctor/getAlldoctors',
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final user = AllDoctorsModel.fromJson(response);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
