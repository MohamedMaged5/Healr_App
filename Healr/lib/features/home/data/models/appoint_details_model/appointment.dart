class Appointment {
	String? bookingFor;
	String? gender;
	String? relation;
	String? problem;
	String? patientId;
	String? doctorName;
	String? doctorId;
	String? doctorImage;
	String? doctorSpecialization;
	String? healthInsuranceCard;
	String? day;
	String? time;
	int? price;
	int? priceHealth;
	int? appointmentId;
	String? id;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? v;

	Appointment({
		this.bookingFor, 
		this.gender, 
		this.relation, 
		this.problem, 
		this.patientId, 
		this.doctorName, 
		this.doctorId, 
		this.doctorImage, 
		this.doctorSpecialization, 
		this.healthInsuranceCard, 
		this.day, 
		this.time, 
		this.price, 
		this.priceHealth, 
		this.appointmentId, 
		this.id, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
				bookingFor: json['bookingFor'] as String?,
				gender: json['gender'] as String?,
				relation: json['relation'] as String?,
				problem: json['problem'] as String?,
				patientId: json['patientId'] as String?,
				doctorName: json['doctorName'] as String?,
				doctorId: json['doctorId'] as String?,
				doctorImage: json['doctorImage'] as String?,
				doctorSpecialization: json['doctorSpecialization'] as String?,
				healthInsuranceCard: json['healthInsuranceCard'] as String?,
				day: json['day'] as String?,
				time: json['time'] as String?,
				price: json['price'] as int?,
				priceHealth: json['priceHealth'] as int?,
				appointmentId: json['appointmentID'] as int?,
				id: json['_id'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
				v: json['__v'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'bookingFor': bookingFor,
				'gender': gender,
				'relation': relation,
				'problem': problem,
				'patientId': patientId,
				'doctorName': doctorName,
				'doctorId': doctorId,
				'doctorImage': doctorImage,
				'doctorSpecialization': doctorSpecialization,
				'healthInsuranceCard': healthInsuranceCard,
				'day': day,
				'time': time,
				'price': price,
				'priceHealth': priceHealth,
				'appointmentID': appointmentId,
				'_id': id,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'__v': v,
			};
}
