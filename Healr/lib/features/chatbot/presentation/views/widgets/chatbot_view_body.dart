import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healr/core/utils/service_locator.dart';
import 'package:healr/features/chatbot/data/chatbot_repo_imp.dart';
import 'package:healr/features/chatbot/models/chat_bot_response.dart';
import 'package:healr/features/chatbot/presentation/manager/chat_bot_message/chat_bot_message_cubit.dart';
import 'package:healr/features/chatbot/presentation/views/widgets/chat_bubble.dart';
import 'package:healr/features/chatbot/presentation/views/widgets/empty_chatbot.dart';
import 'package:healr/features/chatbot/presentation/views/widgets/send_message.dart';

class ChatbotViewBody extends StatefulWidget {
  const ChatbotViewBody({super.key});

  @override
  State<ChatbotViewBody> createState() => _ChatbotViewBodyState();
}

class _ChatbotViewBodyState extends State<ChatbotViewBody> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  List<ChatBotResponse> messageList = [];
  String? finalMessage;

  bool isFound = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBotMessageCubit(getIt.get<ChatbotRepoImp>()),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 20.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<ChatBotMessageCubit, ChatBotMessageState>(
                    listener: (context, state) {
                      if (state is ChatBotMessageSuccess) {
                        messageList = state.messages;
                        if (messageList.isNotEmpty) {
                          finalMessage = messageList.last.response!;
                          isFound = true;
                        } else {
                          isFound = false;
                        }
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                        controller.clear();
                      } else if (state is ChatBotMessageFailure) {
                        finalMessage = state.errMessage;
                        isFound = false;
                      }
                    },
                    builder: (context, state) {
                      if (state is ChatBotMessageFailure) {
                        return Center(
                          child: Text(
                            state.errMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is ChatBotMessageInitial ||
                          (messageList.isEmpty && !isFound)) {
                        return const SingleChildScrollView(
                            child: EmptyChatBot());
                      } else {
                        // For loading state, show messages with loading bubble at the end
                        final isLoading = state is ChatBotMessageLoading;
                        final totalItems =
                            messageList.length + (isLoading ? 1 : 0);

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: totalItems,
                          reverse: false,
                          itemBuilder: (context, index) {
                            // If it's the last item and we're loading, show loading bubble
                            if (isLoading && index == messageList.length) {
                              return const CHatBubbleOthers(
                                message: "",
                                isLoading: true,
                              );
                            }

                            final message = messageList[index];
                            if (message.response == null ||
                                message.response!.isEmpty) {
                              return const SizedBox(); // or show an error widget
                            }
                            final isUser = message.id == "user";
                            return isUser
                                ? ChatBubble(
                                    message: message.response!,
                                  )
                                : CHatBubbleOthers(
                                    message: message.response!,
                                    isLoading: false,
                                  );
                          },
                        );
                      }
                    },
                  ),
                ),
                Builder(builder: (context) {
                  return SendMessage(
                    onTap: () {
                      final message = controller.text;
                      if (message.isNotEmpty) {
                        BlocProvider.of<ChatBotMessageCubit>(context)
                            .sendMessage(message);
                        controller.clear();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        BlocProvider.of<ChatBotMessageCubit>(context)
                            .sendMessage(value);
                        controller.clear();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      }
                    },
                    controller: controller,
                  );
                }),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
