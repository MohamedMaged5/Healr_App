import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/home/data/models/places_model/places_model.dart';
import 'package:healr/features/home/data/repos/places_repo.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlacesRepo repo;

  PlacesCubit(this.repo) : super(PlacesInitial());

  Future<void> fetchHospitals(
      {required double lat, required double lng}) async {
    emit(PlacesLoading());
    try {
      final hospitals = await repo.getNearbyHospitals(lat: lat, lng: lng);
      emit(PlacesLoaded(hospitals));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }
}
