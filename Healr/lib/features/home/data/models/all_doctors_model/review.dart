class Review {
  String? id;
  String? userId;
  String? userName;
  String? userImage;
  String? doctorId;
  String? reviewText;
  int? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Review({
    this.id,
    this.userId,
    this.userName,
    this.userImage,
    this.doctorId,
    this.reviewText,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'] as String?,
        userId: json['userId'] as String?,
        userName: json['userName'] as String?,
        userImage: json['userImage'] as String?,
        doctorId: json['doctorId'] as String?,
        reviewText: json['reviewText'] as String?,
        rating: (json['rating'] as num?)?.toInt(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'userName': userName,
        'userImage': userImage,
        'doctorId': doctorId,
        'reviewText': reviewText,
        'rating': rating,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
