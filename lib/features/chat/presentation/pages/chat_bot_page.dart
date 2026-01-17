import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/presentation/bloc/chat_bot_bloc.dart';
import 'package:inpo_mobile_app/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:intl/intl.dart';

final class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

final class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isStreaming = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<ChatBotBloc>().add(const ChatBotLoadEvent());
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
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

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final isTablet = context.isTablet;
    final isDesktop = context.isDesktop;

    // Responsive sizing
    final appBarHeight = isDesktop
        ? 250.0
        : isTablet
            ? 230.0
            : 211.0;
    final errorMargin = isDesktop
        ? 24.0
        : isTablet
            ? 20.0
            : 16.0;
    final errorPadding = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;
    final errorFontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 14.0;
    final errorBorderRadius = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        animateColor: false,
        surfaceTintColor: Colors.white,
        elevation: 0,
        toolbarHeight: appBarHeight,
        title: const SizedBox.shrink(),
        flexibleSpace:
            HeaderWidget(labelName: "ЧАТ-БОТ", onTap: () => context.go('/')),
      ),
      body: BlocConsumer<ChatBotBloc, ChatBotState>(
        bloc: getIt<ChatBotBloc>(),
        listener: (context, state) {
          if (state is ChatBotLoaded || state is ChatBotProcessing) {
            _scrollToBottom();
          }

          // Обновляем флаг стриминга
          if (state is ChatBotProcessing) {
            _isStreaming = true;
          } else {
            _isStreaming = false;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Баннер ошибки
              if (state is ChatBotError)
                Container(
                  padding: EdgeInsets.all(errorPadding),
                  margin: EdgeInsets.symmetric(
                    horizontal: errorMargin,
                    vertical: errorMargin * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(errorBorderRadius),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      SizedBox(width: errorMargin * 0.75),
                      Expanded(
                        child: Text(
                          _getErrorMessage(state.error),
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: errorFontSize,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close,
                            color: Colors.red.shade700,
                            size: errorFontSize + 6),
                        onPressed: () {
                          getIt<ChatBotBloc>().add(const ChatBotLoadEvent());
                        },
                      ),
                    ],
                  ),
                ),

              // Основной контент
              Expanded(
                child: _buildMessageList(state, isTablet, isDesktop),
              ),

              // Индикатор стриминга
              if (_isStreaming && state is ChatBotProcessing)
                _buildStreamingIndicator(state, isTablet, isDesktop),

              // Поле ввода
              _buildMessageInput(context, state, isTablet, isDesktop),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageList(ChatBotState state, bool isTablet, bool isDesktop) {
    // Responsive sizing
    final loadingFontSize = isDesktop
        ? 18.0
        : isTablet
            ? 17.0
            : 16.0;
    final emptyIconSize = isDesktop
        ? 80.0
        : isTablet
            ? 72.0
            : 64.0;
    final emptyTitleFontSize = isDesktop
        ? 20.0
        : isTablet
            ? 19.0
            : 18.0;
    final emptySubtitleFontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 14.0;
    final listPadding = isDesktop
        ? 24.0
        : isTablet
            ? 20.0
            : 16.0;

    if (state is ChatBotInitial || state is ChatBotLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme.of(context).primaryColor),
            SizedBox(height: listPadding * 0.75),
            Text(
              'Загружаю историю...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: loadingFontSize,
              ),
            ),
          ],
        ),
      );
    }

    if (state is ChatBotLoaded || state is ChatBotProcessing) {
      final messages = state is ChatBotLoaded
          ? state.messages
          : (state as ChatBotProcessing).messages;

      if (messages.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: emptyIconSize,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: listPadding),
              Text(
                'Задайте вопрос чат-боту',
                style: TextStyle(
                  fontSize: emptyTitleFontSize,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: listPadding * 0.5),
              Text(
                'Я помогу вам с любыми вопросами',
                style: TextStyle(
                  fontSize: emptySubtitleFontSize,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(listPadding),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isUser = message.sender == 'user';
          final isStreaming = state is ChatBotProcessing &&
              index == messages.length - 1 &&
              !isUser;

          return _buildMessageItem(
              message, isUser, isStreaming, isTablet, isDesktop);
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildMessageItem(MessageEntity message, bool isUser, bool isStreaming,
      bool isTablet, bool isDesktop) {
    // Responsive sizing
    final avatarSize = isDesktop
        ? 40.0
        : isTablet
            ? 36.0
            : 32.0;
    final avatarIconSize = isDesktop
        ? 22.0
        : isTablet
            ? 20.0
            : 18.0;
    final senderFontSize = isDesktop
        ? 14.0
        : isTablet
            ? 13.0
            : 12.0;
    final messageFontSize = isDesktop
        ? 18.0
        : isTablet
            ? 17.0
            : 16.0;
    final timeFontSize = isDesktop
        ? 13.0
        : isTablet
            ? 12.0
            : 11.0;
    final messageMargin = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final messagePadding = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final borderRadius = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final maxMessageWidth = isDesktop
        ? 0.6
        : isTablet
            ? 0.65
            : 0.75;
    final avatarMargin = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;

    return Container(
      margin: EdgeInsets.only(bottom: messageMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: avatarSize,
              height: avatarSize,
              margin: EdgeInsets.only(right: avatarMargin),
              decoration: BoxDecoration(
                color: const Color(0xff4069D3),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: avatarIconSize,
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Имя отправителя
                Text(
                  isUser ? 'Вы' : 'ИИ-ассистент',
                  style: TextStyle(
                    fontSize: senderFontSize,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: messagePadding * 0.25),

                // Сообщение
                Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width * maxMessageWidth,
                  ),
                  padding: EdgeInsets.all(messagePadding),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xff4069D3)
                        : const Color(0xffF5F7FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: isUser
                          ? Radius.circular(borderRadius)
                          : Radius.circular(borderRadius * 0.25),
                      bottomRight: isUser
                          ? Radius.circular(borderRadius * 0.25)
                          : Radius.circular(borderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(
                          fontSize: messageFontSize,
                          color: isUser ? Colors.white : Colors.black,
                          height: 1.5,
                        ),
                      ),
                      if (isStreaming) const TypingIndicator(),
                    ],
                  ),
                ),

                // Время
                SizedBox(height: messagePadding * 0.25),
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    fontSize: timeFontSize,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          if (isUser)
            Container(
              width: avatarSize,
              height: avatarSize,
              margin: EdgeInsets.only(left: avatarMargin),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey.shade600,
                size: avatarIconSize,
              ),
            ),
        ],
      ),
    );
  }

  // Widget _buildTypingIndicator() {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 8),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         _buildTypingDot(const Duration(milliseconds: 0)),
  //         _buildTypingDot(const Duration(milliseconds: 200)),
  //         _buildTypingDot(const Duration(milliseconds: 400)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildTypingDot(Duration delay) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 2),
  //     child: TweenAnimationBuilder(
  //       tween: Tween<double>(begin: 0, end: 1),
  //       duration: const Duration(milliseconds: 1200),
  //       // delay: delay,
  //       builder: (context, value, child) {
  //         return Opacity(
  //           opacity: value < 0.5 ? value * 2 : 2 - (value * 2),
  //           child: Container(
  //             width: 6,
  //             height: 6,
  //             decoration: BoxDecoration(
  //               color: Colors.grey.shade400,
  //               borderRadius: BorderRadius.circular(3),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildStreamingIndicator(
      ChatBotProcessing state, bool isTablet, bool isDesktop) {
    // Responsive sizing
    final paddingHorizontal = isDesktop
        ? 24.0
        : isTablet
            ? 20.0
            : 16.0;
    final paddingVertical = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;
    final dotSize = isDesktop
        ? 10.0
        : isTablet
            ? 9.0
            : 8.0;
    final dotMargin = isDesktop
        ? 10.0
        : isTablet
            ? 9.0
            : 8.0;
    final fontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 14.0;
    final buttonPaddingHorizontal = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final buttonPaddingVertical = isDesktop
        ? 10.0
        : isTablet
            ? 9.0
            : 8.0;
    final buttonFontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 14.0;
    final borderRadius = isDesktop
        ? 10.0
        : isTablet
            ? 9.0
            : 8.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            margin: EdgeInsets.only(right: dotMargin),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
          Expanded(
            child: Text(
              'ИИ-ассистент печатает...',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontSize: fontSize,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: dotMargin),
            child: ElevatedButton(
              onPressed: () {
                getIt<ChatBotBloc>().add(const ChatBotCancelStreamEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade800,
                padding: EdgeInsets.symmetric(
                  horizontal: buttonPaddingHorizontal,
                  vertical: buttonPaddingVertical,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                elevation: 0,
              ),
              child: Text(
                'ОСТАНОВИТЬ',
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
      BuildContext context, ChatBotState state, bool isTablet, bool isDesktop) {
    final isProcessing = state is ChatBotProcessing;
    final isButtonDisabled = _textController.text.isEmpty || isProcessing;

    // Responsive sizing
    final padding = isDesktop
        ? 24.0
        : isTablet
            ? 20.0
            : 16.0;
    final inputBorderRadius = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;
    final hintFontSize = isDesktop
        ? 18.0
        : isTablet
            ? 17.0
            : 16.0;
    final inputPadding = isDesktop
        ? 20.0
        : isTablet
            ? 18.0
            : 16.0;
    final buttonSize = isDesktop
        ? 56.0
        : isTablet
            ? 52.0
            : 48.0;
    final buttonBorderRadius = isDesktop
        ? 14.0
        : isTablet
            ? 13.0
            : 12.0;
    final buttonIconSize = isDesktop
        ? 28.0
        : isTablet
            ? 26.0
            : 24.0;
    final progressSize = isDesktop
        ? 24.0
        : isTablet
            ? 22.0
            : 20.0;
    final spacing = isDesktop
        ? 16.0
        : isTablet
            ? 14.0
            : 12.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Поле ввода
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: isDesktop
                    ? 140
                    : isTablet
                        ? 130
                        : 120,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF5F7FA),
                borderRadius: BorderRadius.circular(inputBorderRadius),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _textController,
                enabled: !isProcessing,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Напишите сообщение...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: hintFontSize,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(inputPadding),
                  suffixIcon: _textController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey.shade500),
                          onPressed: () {
                            _textController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (text) {
                  _sendMessage();
                },
              ),
            ),
          ),

          SizedBox(width: spacing),

          // Кнопка отправки
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: isButtonDisabled
                  ? Colors.grey.shade300
                  : const Color(0xff4069D3),
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(buttonBorderRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(buttonBorderRadius),
                onTap: isButtonDisabled ? null : _sendMessage,
                child: Center(
                  child: isProcessing
                      ? SizedBox(
                          width: progressSize,
                          height: progressSize,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.send,
                          color: Colors.white,
                          size: buttonIconSize,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      getIt<ChatBotBloc>().add(ChatBotRequestEvent(text));
      _textController.clear();
      setState(() {});
    }
  }

  String _getErrorMessage(Exception error) {
    final errorString = error.toString();

    // Handle rate limiting (429 status code)
    if (errorString.contains('429') ||
        errorString.contains('Too Many Requests')) {
      return 'Слишком много запросов. Пожалуйста, подождите несколько минут перед повторной попыткой.';
    }

    // Handle unprocessable entity (422 status code)
    if (errorString.contains('422') ||
        errorString.contains('Unprocessable Entity')) {
      return 'Некорректный запрос. Пожалуйста, проверьте ваше сообщение и попробуйте снова.';
    }

    // Handle common streaming errors
    if (errorString.contains('Connection failed') ||
        errorString.contains('SocketException') ||
        errorString.contains('Failed host lookup')) {
      return 'Ошибка соединения. Проверьте интернет-соединение.';
    }

    if (errorString.contains('timeout') || errorString.contains('Timeout')) {
      return 'Тайм-аут соединения. Сервер не отвечает.';
    }

    if (errorString.contains('Failed to get AI response')) {
      return 'Не удалось получить ответ от ИИ. Попробуйте позже.';
    }

    if (errorString.contains('Stream error')) {
      return 'Ошибка потоковой передачи. Попробуйте отправить сообщение снова.';
    }

    if (errorString.contains('DioException') ||
        errorString.contains('bad response')) {
      return 'Ошибка сервера. Попробуйте отправить сообщение позже.';
    }

    // Default error message
    return 'Произошла ошибка: ${error.toString().split(':').length > 1 ? error.toString().split(':')[1].trim() : 'неизвестная ошибка'}';
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate.isAtSameMomentAs(today)) {
      return DateFormat('HH:mm').format(timestamp);
    } else if (messageDate.isAfter(today.subtract(const Duration(days: 1)))) {
      return 'Вчера ${DateFormat('HH:mm').format(timestamp)}';
    } else {
      return DateFormat('dd.MM.yyyy HH:mm').format(timestamp);
    }
  }
}
