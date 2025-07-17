import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/login/data/model/user_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserModel>> signUpUser(
      Map<String, dynamic> signUpData);
}
