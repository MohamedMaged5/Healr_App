part of 'reviews_cubit.dart';

sealed class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsCreating extends ReviewsState {}

class ReviewsCreateSuccess extends ReviewsState {}

class ReviewsCreateFailure extends ReviewsState {
  final String errorMessage;

  const ReviewsCreateFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
