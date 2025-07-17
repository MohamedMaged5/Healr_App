import 'data.dart';

class AppointDetailsModel {
	String? status;
	Data? data;

	AppointDetailsModel({this.status, this.data});

	factory AppointDetailsModel.fromJson(Map<String, dynamic> json) {
		return AppointDetailsModel(
			status: json['status'] as String?,
			data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'data': data?.toJson(),
			};
}
