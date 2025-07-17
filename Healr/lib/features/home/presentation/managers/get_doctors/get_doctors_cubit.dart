import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/home/data/models/all_doctors_model/all_doctors_model.dart';
import 'package:healr/features/home/data/repos/get_doctors_repo.dart';

part 'get_doctors_state.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  GetDoctorsCubit(this.getDoctorsRepo) : super(GetDoctorsInitial());
  final GetDoctorsRepo getDoctorsRepo;
  Future<void> allDoctors() async {
    emit(GetDoctorsLoading());

    var result = await getDoctorsRepo.getDoctors();
    result.fold(
      (failure) {
        emit(GetDoctorsFailure(failure.errMessage));
      },
      (user) {
        emit(GetDoctorsSuccess(user));
      },
    );
  }
}
