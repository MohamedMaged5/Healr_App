import 'appointment.dart';

class Data {
	Appointment? appointment;

	Data({this.appointment});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				appointment: json['appointment'] == null
						? null
						: Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'appointment': appointment?.toJson(),
			};
}
