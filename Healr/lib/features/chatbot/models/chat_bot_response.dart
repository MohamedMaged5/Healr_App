class ChatBotResponse {
  String? message;
  String? response;
  String? id;
  String? sendAt;

  ChatBotResponse({this.message, this.response, this.id, this.sendAt});

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    return ChatBotResponse(
      message: json['message'] as String?,
      response: json['response'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'response': response,
      };
}
