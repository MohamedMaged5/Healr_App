import 'package:intl/intl.dart';

class MedicineModel {
  final String name;
  final String dosage;
  final  List<String> times;
  final int numberOfTimes;
  final String? doctorName;
  final String timeOfCreation;
  final String? id;
  final int durationInDays;
  final String image;
  final String notes;

  MedicineModel({
    required this.name,
    required this.dosage,
    required this.times,
    required this.numberOfTimes,
    required this.doctorName,
    required this.timeOfCreation,
    required this.id,
    required this.durationInDays,
    required this.image,
    required this.notes,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      name: json['medicineName'],
      dosage: json['medicineDosage'],
      times: List<String>.from(json['time'] ?? []),
      numberOfTimes: json['NumberOfTimes'] ?? 2,
      doctorName: json['doctorId']['name'] ?? 'Unknown Doctor',
      timeOfCreation: json['createdAt'] ?? DateTime.now().toIso8601String(),
      id: json['_id'] ?? 'unknown_id',
      durationInDays: json['durationInDays'] ?? 7,
      image: json['doctorId']['image'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
  MedicineModel copyWith({
    String? name,
    String? dosage,
    List<String>? times,
    int? numberOfTimes,
    String? doctorName,
    String? timeOfCreation,
    String? id,
    int? durationInDays,
    String? image,
    String? notes,

  }) {
    return MedicineModel(

      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      times: times ?? this.times,
      numberOfTimes: numberOfTimes ?? this.numberOfTimes,
      doctorName: doctorName ?? this.doctorName,
      timeOfCreation: timeOfCreation ?? this.timeOfCreation,
      id: id ?? this.id,
      durationInDays: durationInDays ?? this.durationInDays,
      image: image ?? this.image,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'notes': notes,
        'medicineName': name,
        'medicineDosage': dosage,
        'time': times,
        'NumberOfTimes': numberOfTimes,
        'doctorId': {
          'name': doctorName,
          'id': id,
          'image': image,
        },
        'createdAt': timeOfCreation,
        '_id': id,
      };

  String get formattedCreationTime {
    final date = DateTime.parse(timeOfCreation).add(const Duration(hours: 3));
    return DateFormat('hh:mm a').format(date);
  }
}
