part of 'chat_bot_message_cubit.dart';

sealed class ChatBotMessageState extends Equatable {
  const ChatBotMessageState();

  @override
  List<Object> get props => [];
}

final class ChatBotMessageInitial extends ChatBotMessageState {}

final class ChatBotMessageLoading extends ChatBotMessageState {}

final class ChatBotMessageSuccess extends ChatBotMessageState {
  final List<ChatBotResponse> messages;

  const ChatBotMessageSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

final class ChatBotMessageFailure extends ChatBotMessageState {
  final String errMessage;

  const ChatBotMessageFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
