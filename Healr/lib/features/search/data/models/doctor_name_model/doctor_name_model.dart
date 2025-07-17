import 'search_name.dart';

class DoctorNameModel {
  bool? status;
  List<SearchName>? data;

  DoctorNameModel({this.status, this.data});

  factory DoctorNameModel.fromJson(Map<String, dynamic> json) {
    return DoctorNameModel(
      status: json['Status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchName.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
