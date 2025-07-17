import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/profile/data/model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, ProfileModel>> updateProfile(
    String? phone,
    String? gender,
    String? date,
    String? bloodType,
    String? notes,
  );
  Future<Either<Failure, ProfileModel>> updateProfileImage(String imagePath);
  Future<Either<Failure, String>> fetchProfileImage();
}
