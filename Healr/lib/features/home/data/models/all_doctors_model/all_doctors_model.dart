import 'datum.dart';

class AllDoctorsModel {
	String? status;
	int? numberOfDocuments;
	List<Datum>? data;

	AllDoctorsModel({this.status, this.numberOfDocuments, this.data});

	factory AllDoctorsModel.fromJson(Map<String, dynamic> json) {
		return AllDoctorsModel(
			status: json['Status'] as String?,
			numberOfDocuments: json['Number of documents'] as int?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'Status': status,
				'Number of documents': numberOfDocuments,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
