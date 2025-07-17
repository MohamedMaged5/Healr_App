import 'package:dartz/dartz.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/features/chatbot/models/chat_bot_response.dart';

abstract class ChatbotRepo {
  Future<Either<Failure, ChatBotResponse>> sendSymptoms(String symptoms);
}
