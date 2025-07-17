import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/api_service.dart';
import 'package:healr/features/chatbot/data/chatbot_repo.dart';
import 'package:healr/features/chatbot/models/chat_bot_response.dart';
import 'package:http/http.dart' as http;

class ChatbotRepoImp implements ChatbotRepo {
  String responseText = '';

  ChatbotRepoImp(ApiService apiService);
  @override
  Future<Either<Failure, ChatBotResponse>> sendSymptoms(String symptoms) async {
    final url =
        Uri.parse('https://chatbot-production-bfef.up.railway.app/chatbot');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'symptoms': symptoms});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final chatBotResponse = ChatBotResponse.fromJson(data);
        return Right(chatBotResponse);
      } else {
        return Left(
            ServerFailure('❌ Server connection error: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('⚠️ Unexpected error occurred: $e'));
    }
  }
}
