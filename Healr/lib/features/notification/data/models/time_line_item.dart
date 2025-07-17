import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/data/models/notification_model.dart';

abstract class TimelineItem {
  DateTime get createdAt;
}

class TimelineMedicineItem extends TimelineItem {
  final MedicineModel medicine;

  TimelineMedicineItem(this.medicine);

  @override
  DateTime get createdAt => DateTime.parse(medicine.timeOfCreation);
}

class TimelineNotificationItem extends TimelineItem {
  final NotificationModel notification;

  TimelineNotificationItem(this.notification);

  @override
  DateTime get createdAt => DateTime.parse(notification.createdAt);
}
