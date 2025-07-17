import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/login/data/model/forget_pass_model.dart';

abstract class VerificationRepo {
  Future<Either<Failure, ForgetPassModel>> verification(String code);
}
