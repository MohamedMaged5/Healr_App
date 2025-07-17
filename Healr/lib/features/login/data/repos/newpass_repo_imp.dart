import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/newpass_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewpassRepoImp implements NewpassRepo {
  final ApiService apiService;

  NewpassRepoImp(this.apiService);

  @override
  Future<Either<Failure, ForgetPassModel>> newpass(
      String password, String confirmPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Resettoken') ?? '';
      final response = await apiService.put(
        endPoint: 'resetpassword',
        body: {
          'newPassword': password,
          'passwordConfirm': confirmPassword,
        },
        token: token,
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
