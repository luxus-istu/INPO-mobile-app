import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/presentation/bloc/chat_bot_bloc.dart';
import 'package:inpo_mobile_app/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:intl/intl.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getIt<ChatBotBloc>().add(const ChatBotLoadEvent());
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        animateColor: false,
        surfaceTintColor: Colors.white,
        toolbarHeight: 245,
        title: const SizedBox.shrink(),
        flexibleSpace:
            HeaderWidget(labelName: "ЧАТ-БОТ", onTap: () => context.go('/')),
      ),
      body: BlocConsumer<ChatBotBloc, ChatBotState>(
        bloc: getIt<ChatBotBloc>(),
        listener: (context, state) {
          if (state is ChatBotLoaded || state is ChatBotProcessing) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state is ChatBotError)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.shade300,
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(state.exception.toString(),
                              style: const TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              Expanded(
                child: _buildBody(state, _scrollController),
              ),
              _buildMessageComposer(
                  context, _textController, state is ChatBotProcessing),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(ChatBotState state, ScrollController scrollController) {
    if (state is ChatBotInitial || state is ChatBotLoading) {
      return const Center(
          child: CircularProgressIndicator(color: Color(0xff4069D3)));
    }

    if (state is ChatBotLoaded || state is ChatBotProcessing) {
      final messages = state is ChatBotLoaded
          ? state.messages
          : (state as ChatBotProcessing).messages;

      return ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: messages.length + (state is ChatBotProcessing ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == messages.length && state is ChatBotProcessing) {
            return const TypingIndicator();
          }

          final message = messages[index];
          final isUser = message.sender == 'user';
          return _buildMessageBubble(message, isUser);
        },
      );
    }

    return const SizedBox.shrink();
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }

  Widget _buildMessageBubble(MessageEntity message, bool isUser) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xff4069D3)
                        : const Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "SF Pro Display",
                      fontSize: 16,
                      color: isUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff8F8F8F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer(
      BuildContext context, TextEditingController controller, bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        color: Color(0xffF3F3F3),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              enabled: !isLoading,
              decoration: const InputDecoration.collapsed(
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    color: Color(0xff8F8F8F),
                  ),
                  hintText: 'Задай свой вопрос...'),
              onSubmitted: (text) {
                if (text.isNotEmpty && !isLoading) {
                  getIt<ChatBotBloc>().add(ChatBotRequestEvent(text));
                  controller.clear();
                }
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                color: Color(0xff4069D3),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  getIt<ChatBotBloc>()
                      .add(ChatBotRequestEvent(controller.text));
                  controller.clear();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xff9FBAFF)),
                child: const Icon(Icons.arrow_upward,
                    size: 32, color: Colors.white),
              ),
            )
        ],
      ),
    );
  }
}
