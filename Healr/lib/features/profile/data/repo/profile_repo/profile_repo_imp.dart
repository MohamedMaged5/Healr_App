import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:healr/features/profile/data/model/profile_model.dart';
import 'package:healr/features/profile/data/repo/profile_repo/profile_repo.dart';

class ProfileRepoImp implements ProfileRepo {
  final ApiService apiService;

  ProfileRepoImp(this.apiService);

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await apiService.get(endPoint: 'profile/getProfile');
      final name = response['data']['name'];
      final nationalID = response['data']['nationalID'];
      final phoneNumber = response['data']['mobilePhone'];
      final email = response['data']['email'];

      SharedPrefCache.saveCache(key: 'name', value: name);
      SharedPrefCache.saveCache(key: 'nationalID', value: nationalID);
      SharedPrefCache.saveCache(key: 'phone', value: phoneNumber);
      SharedPrefCache.saveCache(key: 'email', value: email);

      final gender = SharedPrefCache.getCache(key: 'gender');
      final date = SharedPrefCache.getCache(key: 'date');
      final blood = SharedPrefCache.getCache(key: 'blood');
      final notes = SharedPrefCache.getCache(key: 'notes');
      final image = SharedPrefCache.getCache(key: 'image');

      return Right(ProfileModel(
        name: name,
        nationalID: nationalID,
        phoneNumber: phoneNumber,
        email: email,
        gender: gender,
        date: date,
        bloodType: blood,
        notes: notes,
        image: image,
      ));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile(
    String? gender,
    String? date,
    String? notes,
    String? blood,
    String? phone,
  ) async {
    try {
      final formData = FormData.fromMap({
        if (phone != null) 'phone': phone,
        if (gender != null) 'gender': gender,
        if (date != null) 'date': date,
        if (blood != null) 'blood': blood,
        if (notes != null) 'notes': notes,
      });

      final response = await apiService.patchFormData(
        endPoint: 'profile/updateProfile',
        formData: formData,
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      var result = response['data']['profile'];
      final rawDate = result['date'];
      final formattedDate = rawDate != null
          ? DateTime.parse(rawDate)
              .toLocal()
              .toString()
              .split(' ')[0]
              .split('-')
              .reversed
              .join('/')
          : null;

      SharedPrefCache.saveCache(key: 'gender', value: result['gender'] ?? '');
      SharedPrefCache.saveCache(key: 'date', value: formattedDate ?? '');
      SharedPrefCache.saveCache(key: 'blood', value: result['blood'] ?? '');
      SharedPrefCache.saveCache(key: 'notes', value: result['notes'] ?? '');
      SharedPrefCache.saveCache(key: 'image', value: result['image'] ?? '');
      SharedPrefCache.saveCache(
          key: 'phoneNumber', value: result['phone'] ?? '');

      final name = SharedPrefCache.getCache(key: 'name');
      final nationalID = SharedPrefCache.getCache(key: 'nationalID');
      final email = SharedPrefCache.getCache(key: 'email');

      return Right(ProfileModel(
        name: name,
        nationalID: nationalID,
        phoneNumber: result['phone'] ?? '',
        email: email,
        gender: result['gender'],
        date: formattedDate,
        bloodType: result['blood'],
        notes: result['notes'],
        image: result['image'],
      ));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfileImage(
      String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
      });

      final response = await apiService.patchFormData(
        endPoint: 'profile/updateImageProfile',
        formData: formData,
      );

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final result = response['data'];
      print('Image updated successfully: ${result['image']}');

      SharedPrefCache.saveCache(key: 'image', value: result['image'] ?? '');

      return Right(ProfileModel(
        image: result['image'] ?? '',
      ));
    } on DioException catch (e) {
      return Left(ServerFailure('❌ Dio error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> fetchProfileImage() async {
    try {
      final response = await apiService.get(endPoint: 'profile/getLastImage');

      if (response.containsKey('status') && response['status'] == 'error') {
        return Left(ServerFailure(response['message']));
      }

      final image = response['data']['image'] ?? '';
      SharedPrefCache.saveCache(key: 'image', value: image);
      return Right(image);
    } catch (e) {
      return Left(ServerFailure('⚠️ Failed to fetch image: $e'));
    }
  }
}
