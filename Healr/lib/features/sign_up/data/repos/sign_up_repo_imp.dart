import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/login/data/model/user_model.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo_imp.dart';
import 'package:healr/features/sign_up/data/repos/sign_up_repo.dart';

class SignUpRepoImp implements SignUpRepo {
  final ApiService apiService;
  String? token;

  SignUpRepoImp(this.apiService);

  @override
  Future<Either<Failure, UserModel>> signUpUser(
      Map<String, dynamic> signUpData) async {
    try {
      final response = await apiService.post(
        endPoint: 'signUp',
        body: signUpData,
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }
      if (response.containsKey('msg')) {
        return Left(ServerFailure(response['msg']));
      }
      print('SignUp response: ${signUpData['msg']})');

      final user = UserModel.fromJson(response);

      if (response.containsKey('token')) {
        await SharedPrefCache.saveCache(key: 'token', value: response['token']);
      }

      // @MohamedMaged5 i saved the user data in shared preferences so i can use it in the profile
      final userData = response['data']['user'];
      await SharedPrefCache.saveCache(key: 'name', value: userData['name']);
      await SharedPrefCache.saveCache(
          key: 'nationalID', value: userData['nationalID']);
      await SharedPrefCache.saveCache(
          key: 'phone', value: userData['mobilePhone']);
      await SharedPrefCache.saveCache(key: 'email', value: userData['email']);
      await getIt<ProfileRepoImp>().getProfile();

      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
