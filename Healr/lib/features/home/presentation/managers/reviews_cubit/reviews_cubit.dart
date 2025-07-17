import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healr/features/home/data/repos/reviews_repo.dart';
part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this.reviewsRepo) : super(ReviewsInitial());
  final ReviewsRepo reviewsRepo;

  Future<void> createReview(String review, int rating, String doctorID) async {
    emit(ReviewsCreating());
    var result = await reviewsRepo.createReview(review, rating, doctorID);
    result.fold(
      (failure) => emit(ReviewsCreateFailure(failure.errMessage)),
      (success) {
        emit(ReviewsCreateSuccess());
      },
    );
  }
}
