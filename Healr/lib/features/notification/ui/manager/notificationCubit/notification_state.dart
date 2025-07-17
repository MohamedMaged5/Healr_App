import 'package:equatable/equatable.dart';
import 'package:healr/features/notification/data/models/time_line_item.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationMixedSuccess extends NotificationState {
  final List<TimelineItem> items;

  const NotificationMixedSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class NotificationFailure extends NotificationState {
  final String message;

  const NotificationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationEmpty extends NotificationState {}
