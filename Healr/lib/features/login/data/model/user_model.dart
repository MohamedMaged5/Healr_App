class UserModel {
  final bool status;
  final String message;
  final String token;

  UserModel({
    required this.status,
    required this.message,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Message': message,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['Status'] ?? json['status'] ?? false,
      message: json['Message'] ?? json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
