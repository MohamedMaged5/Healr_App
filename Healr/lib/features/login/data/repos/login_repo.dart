import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/login/data/model/user_model.dart';

abstract class LoginRepo {

  Future<Either<Failure, UserModel>> loginUser(String nationalID, String password);
  Future<Either<Failure, UserModel>> loginWithEmail(String email, String password);
}
