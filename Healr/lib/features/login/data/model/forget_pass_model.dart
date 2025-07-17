class ForgetPassModel {
  final String status;
  final String message;
  final String token;

  ForgetPassModel({
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

  factory ForgetPassModel.fromJson(Map<String, dynamic> json) {
    return ForgetPassModel(
      status: json['Status'] ?? json['status'] ?? '',
      message: json['Message'] ?? json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
