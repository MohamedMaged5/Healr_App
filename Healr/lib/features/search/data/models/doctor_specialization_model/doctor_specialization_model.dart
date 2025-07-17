import 'search_specializtion.dart';

class DoctorSpecializationModel {
  bool? status;
  List<SearchSpecialization>? data;

  DoctorSpecializationModel({this.status, this.data});

  factory DoctorSpecializationModel.fromJson(Map<String, dynamic> json) {
    return DoctorSpecializationModel(
      status: json['Status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchSpecialization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
