part of 'notification_actions_cubit.dart';

sealed class NotificationActionsState extends Equatable {
  const NotificationActionsState();

  @override
  List<Object> get props => [];
}

final class NotificationActionsInitial extends NotificationActionsState {}

final class IdleNotification extends NotificationActionsState {}

final class SelectingNotification extends NotificationActionsState {}

final class DeSelectingNotification extends NotificationActionsState {}

final class DeletingNotifications extends NotificationActionsState {}

final class MarkAllNotificationsAsReading extends NotificationActionsState {}
