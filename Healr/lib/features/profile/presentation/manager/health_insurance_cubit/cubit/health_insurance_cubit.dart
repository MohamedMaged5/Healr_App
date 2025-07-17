import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healr/features/profile/data/model/health_insurance_model.dart';
import 'package:healr/features/profile/data/repo/health_insurance_repo/health_insurance_repo.dart';

part 'health_insurance_state.dart';

class HealthInsuranceCubit extends Cubit<HealthInsuranceState> {
  HealthInsuranceCubit(this.healthInsuranceRepo)
      : super(HealthInsuranceInitial());
  final HealthInsuranceRepo healthInsuranceRepo;

  Future<void> addHealthInsurance({
    required String headFamily,
    required String beneficiaryName,
    required String healthUnit,
    required String fileNumber,
  }) async {
    emit(HealthInsuranceLoading());

    final result = await healthInsuranceRepo.addHealthInsurance(
      headFamily,
      beneficiaryName,
      healthUnit,
      fileNumber,
    );

    result.fold(
      (failure) => emit(HealthInsuranceError(failure.errMessage)),
      (healthInsurance) =>
          emit(HealthInsuranceAdded(healthInsurance: healthInsurance)),
    );
  }

  Future<void> getHealthInsurance() async {
    emit(HealthInsuranceLoading());

    final result = await healthInsuranceRepo.getHealthInsurance();

    result.fold(
      (failure) => emit(HealthInsuranceError(failure.errMessage)),
      (healthInsurance) {
        if (healthInsurance == null) {
          emit(HealthInsuranceEmpty());
        } else {
          emit(HealthInsuranceFetched(healthInsurance: healthInsurance));
        }
      },
    );
  }

  Future<void> deleteHealthInsurance() async {
    emit(HealthInsuranceLoading());

    final result = await healthInsuranceRepo.deleteHealthInsurance();

    result.fold(
      (failure) => emit(HealthInsuranceDeleteError(failure.errMessage)),
      (message) => emit(const HealthInsuranceDeleted()),
    );
  }
}
