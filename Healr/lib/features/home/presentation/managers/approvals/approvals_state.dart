part of 'approvals_cubit.dart';

sealed class ApprovalsState extends Equatable {
  const ApprovalsState();

  @override
  List<Object> get props => [];
}

final class ApprovalsInitial extends ApprovalsState {}

final class ApprovalsLoading extends ApprovalsState {}
