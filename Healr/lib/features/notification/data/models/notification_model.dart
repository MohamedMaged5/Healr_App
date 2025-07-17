import 'package:intl/intl.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String userId;
  final String createdAt;
  final String image; 

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.userId,
    required this.createdAt,
    required this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'].toString(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'message': message,
      'userId': userId,
      'createdAt': createdAt,
      'image': image,
    };
  }

  String get formattedCreationTime {
  final date = DateTime.parse(createdAt).add(const Duration(hours: 3));
  return DateFormat('hh:mm a').format(date);
}

}
