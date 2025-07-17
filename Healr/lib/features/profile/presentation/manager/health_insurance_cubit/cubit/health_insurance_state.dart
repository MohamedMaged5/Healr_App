part of 'health_insurance_cubit.dart';

sealed class HealthInsuranceState extends Equatable {
  const HealthInsuranceState();

  @override
  List<Object> get props => [];
}

final class HealthInsuranceInitial extends HealthInsuranceState {}

final class HealthInsuranceLoading extends HealthInsuranceState {}

final class HealthInsuranceAdded extends HealthInsuranceState {
  final HealthInsuranceModel healthInsurance;
  const HealthInsuranceAdded({
    required this.healthInsurance,
  });
}

final class HealthInsuranceError extends HealthInsuranceState {
  final String message;
  const HealthInsuranceError(this.message);

  @override
  List<Object> get props => [message];
}

final class HealthInsuranceFetched extends HealthInsuranceState {
  final HealthInsuranceModel? healthInsurance;
  const HealthInsuranceFetched({
    required this.healthInsurance,
  });
}

final class HealthInsuranceEmpty extends HealthInsuranceState {}

final class HealthInsuranceDeleted extends HealthInsuranceState {
  const HealthInsuranceDeleted();
}

final class HealthInsuranceDeleteError extends HealthInsuranceState {
  final String message;
  const HealthInsuranceDeleteError(this.message);

  @override
  List<Object> get props => [message];
}
