import 'review.dart';

class Datum {
  int? price;
  String? id;
  String? image;
  String? name;
  String? nationalId;
  String? specialization;
  int? exp;
  double? rate;
  List<dynamic>? doctorSchedule;
  List<Review>? reviews;
  List<dynamic>? workingHours;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? appointmentPrice;

  Datum({
    this.price,
    this.id,
    this.image,
    this.name,
    this.nationalId,
    this.specialization,
    this.exp,
    this.rate,
    this.doctorSchedule,
    this.reviews,
    this.workingHours,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.appointmentPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        price: json['price'] as int?,
        id: json['_id'] as String?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        nationalId: json['nationalID'] as String?,
        specialization: json['specialization'] as String?,
        exp: json['exp'] as int?,
        rate: (json['rate'] as num?)?.toDouble(),
        doctorSchedule: json['doctorSchedule'] as List<dynamic>?,
        reviews: json['reviews'] != null
            ? (json['reviews'] as List<dynamic>)
                .map((reviewJson) =>
                    Review.fromJson(reviewJson as Map<String, dynamic>))
                .toList()
            : null,
        workingHours: json['workingHours'] as List<dynamic>?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        appointmentPrice: json['appointmentPrice'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        '_id': id,
        'image': image,
        'name': name,
        'nationalID': nationalId,
        'specialization': specialization,
        'exp': exp,
        'rate': rate,
        'doctorSchedule': doctorSchedule,
        'reviews': reviews?.map((review) => review.toJson()).toList(),
        'workingHours': workingHours,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'appointmentPrice': appointmentPrice,
      };
}
