class ProfileModel {
  final String? name;
  final String? email;
  final String? nationalID;
  final String? phoneNumber;
  final String? date;
  final String? gender;
  final String? bloodType;
  final String? notes;
  final String? image;

  ProfileModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.nationalID,
    this.bloodType,
    this.date,
    this.gender,
    this.notes,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['data']['name'] ?? '',
      email: json['data']['email'] ?? '',
      phoneNumber: json['data']['mobilePhone'] ?? '',
      nationalID: json['data']['nationalID'] ?? '',
      bloodType: json['data']['bloodType'],
      date: json['data']['date'],
      gender: json['data']['gender'],
      notes: json['data']['notes'],
      image: json['data']['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobilePhone': phoneNumber,
      'nationalId': nationalID,
      'bloodType': bloodType,
      'date': date,
      'gender': gender,
      'notes': notes,
      'image': image,
    };
  }

  ProfileModel copyWith({
    String? name,
    String? email,
    String? nationalID,
    String? phoneNumber,
    String? date,
    String? gender,
    String? bloodType,
    String? notes,
    String? image,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      nationalID: nationalID ?? this.nationalID,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      notes: notes ?? this.notes,
      image: image ?? this.image,
    );
  }
}
