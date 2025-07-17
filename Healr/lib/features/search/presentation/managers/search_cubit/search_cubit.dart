import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/search/data/models/doctor_name_model/doctor_name_model.dart';
import 'package:healr/features/search/data/models/doctor_specialization_model/doctor_specialization_model.dart';
import 'package:healr/features/search/data/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;
  Future<void> specialtiesSearch(String specialization) async {
    emit(SearchLoading());

    var result = await searchRepo.specializationSearch(specialization);
    result.fold(
      (failure) {
        // Check if it's a 404 error (no doctors found)
        if (failure.errMessage.contains('Resource not found.') ||
            failure.errMessage.contains('404')) {
          emit(const SearchFailure(
              'No doctors found with this specialization. Try searching for a different specialty.'));
        } else {
          emit(SearchFailure(failure.errMessage));
        }
      },
      (user) {
        emit(SearchSuccessSpecial(user));
      },
    );
  }

  Future<void> nameSearch(String name) async {
    emit(SearchLoading());

    var result = await searchRepo.nameSearch(name);
    result.fold(
      (failure) {
        // Check if it's a 404 error (no doctors found)
        if (failure.errMessage.contains('Resource not found.') ||
            failure.errMessage.contains('404')) {
          emit(const SearchFailure(
              'No doctors found with that name. Please check the spelling or try a different search.'));
        } else {
          emit(SearchFailure(failure.errMessage));
        }
      },
      (user) {
        emit(SearchSuccessName(user));
      },
    );
  }

  void reset() {
    emit(SearchInitial());
  }
}
