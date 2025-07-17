import 'package:healr/features/home/data/models/all_doctors_model/review.dart';

class SearchSpecialization {
  String? image;
  String? name;
  String? specialization;
  double? rate;
  List<Review>? reviews;
  int? exp;
  String? id;

  SearchSpecialization(
      {this.image,
      this.name,
      this.specialization,
      this.rate,
      this.reviews,
      this.exp,
      this.id});

  factory SearchSpecialization.fromJson(Map<String, dynamic> json) =>
      SearchSpecialization(
        image: json['image'] as String?,
        name: json['name'] as String?,
        specialization: json['specialization'] as String?,
        rate: (json['rate'] as num?)?.toDouble(),
        reviews: json['reviews'] != null
            ? (json['reviews'] as List<dynamic>)
                .map((reviewJson) =>
                    Review.fromJson(reviewJson as Map<String, dynamic>))
                .toList()
            : null,
        exp: json['exp'] as int?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'specialization': specialization,
        'rate': rate,
        'reviews': reviews?.map((review) => review.toJson()).toList(),
        'exp': exp,
        '_id': id,
      };
}
