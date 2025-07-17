part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccessName extends SearchState {
  final DoctorNameModel name;

  const SearchSuccessName(this.name);

  @override
  List<Object> get props => [name];
}

final class SearchSuccessSpecial extends SearchState {
  final DoctorSpecializationModel specialization;

  const SearchSuccessSpecial(this.specialization);

  @override
  List<Object> get props => [specialization];
}

final class SearchFailure extends SearchState {
  final String errMessage;

  const SearchFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
