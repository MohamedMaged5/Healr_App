import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/verification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationRepoImp implements VerificationRepo {
  final ApiService apiService;

  VerificationRepoImp(this.apiService);

  @override
  Future<Either<Failure, ForgetPassModel>> verification(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Resettoken') ?? '';
      print(code);
      final response = await apiService.postt(
        endPoint: 'verifycode',
        body: {
          'resetCode': code,
        },
        token: token, // or your saved token if needed
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final user = ForgetPassModel.fromJson(response);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
