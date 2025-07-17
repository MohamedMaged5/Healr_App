import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, dynamic>> createReview(
      String review, int rating, String doctorID);
}
