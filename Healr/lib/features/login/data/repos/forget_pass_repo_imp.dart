import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';
import 'package:healr/features/login/data/repos/forget_pass_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassRepoImp implements ForgetPassRepo {
  final ApiService apiService;

  ForgetPassRepoImp(this.apiService);

  @override
  Future<Either<Failure, ForgetPassModel>> forgetpass(String email) async {
    try {
      final response = await apiService.post(
        endPoint: 'forgetpass',
        body: {
          'Email': email,
        },
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final user = ForgetPassModel.fromJson(response);
      if (response.containsKey('token')) {
        final token = user.token;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Resettoken', token);
      }
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
