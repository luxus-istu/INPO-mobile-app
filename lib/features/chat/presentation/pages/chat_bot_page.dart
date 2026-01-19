import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:inpo_mobile_app/core/di/injection.dart';
import 'package:inpo_mobile_app/core/presentation/widgets/header_widget.dart';
import 'package:inpo_mobile_app/core/presentation/utils/screen_size_extensions.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/presentation/bloc/chat_bot_bloc.dart';
import 'package:inpo_mobile_app/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<ChatBotBloc>().add(const ChatBotLoadEvent());
    });

    _textController.addListener(() {
      final composing = _textController.text.trim().isNotEmpty;
      if (_isComposing != composing && mounted) {
        setState(() => _isComposing = composing);
      }
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

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    getIt<ChatBotBloc>().add(ChatBotSendMessageEvent(text));
    _textController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: isTablet ? 230 : 110,
        title: const SizedBox.shrink(),
        flexibleSpace: HeaderWidget(
          labelName: l10n.chatHeader,
        ),
      ),
      body: BlocConsumer<ChatBotBloc, ChatBotState>(
        bloc: getIt<ChatBotBloc>(),
        listener: (context, state) {
          if (state is ChatBotLoaded || state is ChatBotProcessing) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          final isProcessing = state is ChatBotProcessing;

          return Column(
            children: [
              if (state is ChatBotError)
                _ErrorBanner(
                  error: state.error,
                  isTablet: isTablet,
                  onClose: () =>
                      getIt<ChatBotBloc>().add(const ChatBotLoadEvent()),
                ),
              Expanded(
                child: _MessageList(
                  state: state,
                  scrollController: _scrollController,
                  isTablet: isTablet,
                  l10n: l10n,
                ),
              ),
              // Убрали _TypingBar полностью — теперь индикация только внутри bubble
              _MessageInput(
                controller: _textController,
                isProcessing: isProcessing,
                isComposing: _isComposing,
                isTablet: isTablet,
                l10n: l10n,
                onSend: _sendMessage,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ────────────────────────────────────────────────
// Helper Widgets
// ────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final Exception error;
  final bool isTablet;
  final VoidCallback onClose;

  const _ErrorBanner({
    required this.error,
    required this.isTablet,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final msg =
        _getUserFriendlyError(error.toString(), AppLocalizations.of(context)!);
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16, vertical: 10),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              msg,
              style: TextStyle(
                  color: Colors.red.shade800, fontSize: isTablet ? 15 : 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.redAccent),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final ChatBotState state;
  final ScrollController scrollController;
  final bool isTablet;
  final AppLocalizations l10n;

  const _MessageList({
    required this.state,
    required this.scrollController,
    required this.isTablet,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ChatBotInitial || state is ChatBotLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.loadingHistory,
                style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      );
    }

    final messages = switch (state) {
      ChatBotLoaded(messages: final m) => m,
      ChatBotProcessing(messages: final m) => m,
      _ => <MessageEntity>[],
    };

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline_rounded,
                size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(l10n.askQuestion,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              l10n.helpWithQuestions,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isUser = msg.sender == 'user';

        return _MessageBubble(
          message: msg,
          isUser: isUser,
          isTablet: isTablet,
          state: state,
          index: index,
          messages: messages,
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isUser;
  final bool isTablet;
  final ChatBotState state;
  final int index;
  final List<MessageEntity> messages;

  const _MessageBubble({
    required this.message,
    required this.isUser,
    required this.isTablet,
    required this.state,
    required this.index,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final isLastAiMessage = !isUser && index == messages.length - 1;
    final isStreaming =
        state is ChatBotProcessing && (state as ChatBotProcessing).isStreaming;

    // Показываем "думаю..." только пока текст пустой и идёт генерация
    final showThinking =
        isLastAiMessage && isStreaming && message.text.trim().isEmpty;

    final borderRadius = isTablet ? 20.0 : 18.0;
    final maxWidthFactor = isTablet ? 0.68 : 0.78;

    return Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 20 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _Avatar(isUser: false, size: isTablet ? 44 : 40),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUser ? 'You' : 'AI',
                  style: TextStyle(
                      fontSize: isTablet ? 13 : 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * maxWidthFactor,
                  ),
                  padding: EdgeInsets.all(isTablet ? 16 : 14),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF4069D3)
                        : const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                      bottomLeft:
                          isUser ? Radius.circular(borderRadius) : Radius.zero,
                      bottomRight:
                          isUser ? Radius.zero : Radius.circular(borderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Текст сообщения
                      if (message.text.isNotEmpty)
                        GptMarkdown(message.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              height: 1.45,
                              fontSize: isTablet ? 16.5 : 15.5,
                            )),
                      // Text(
                      //   message.text,
                      //   style: TextStyle(
                      //     color: isUser ? Colors.white : Colors.black87,
                      //     height: 1.45,
                      //     fontSize: isTablet ? 16.5 : 15.5,
                      //   ),
                      // ),

                      // Индикатор "думаю..." — только внутри bubble, на русском
                      if (showThinking) const TypingIndicator()
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                      fontSize: isTablet ? 12 : 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 12),
            _Avatar(isUser: true, size: isTablet ? 44 : 40),
          ],
        ],
      ),
    );
  }
}

// Остальные классы без изменений: _Avatar, _MessageInput, _getUserFriendlyError, _formatTime

class _Avatar extends StatelessWidget {
  final bool isUser;
  final double size;

  const _Avatar({required this.isUser, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isUser ? Colors.grey[300] : const Color(0xFF4069D3),
        borderRadius: BorderRadius.circular(size * 0.4),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: isUser ? Colors.grey[700] : Colors.white,
        size: size * 0.55,
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isProcessing;
  final bool isComposing;
  final bool isTablet;
  final AppLocalizations l10n;
  final VoidCallback onSend;

  const _MessageInput({
    required this.controller,
    required this.isProcessing,
    required this.isComposing,
    required this.isTablet,
    required this.l10n,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final canSend = isComposing && !isProcessing;

    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: isTablet ? 140 : 120),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(isTablet ? 16 : 14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller,
                enabled: !isProcessing,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: l10n.typeMessage,
                  hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: isTablet ? 16.5 : 15.5),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(isTablet ? 18 : 16),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded,
                              color: Colors.grey),
                          onPressed: controller.clear,
                        )
                      : null,
                ),
                onSubmitted: (_) => canSend ? onSend() : null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: isTablet ? 56 : 52,
            height: isTablet ? 56 : 52,
            child: FloatingActionButton(
              onPressed: canSend ? onSend : null,
              backgroundColor:
                  canSend ? const Color(0xFF4069D3) : Colors.grey[300],
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: isProcessing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: Colors.white),
                    )
                  : const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

String _getUserFriendlyError(String errorStr, AppLocalizations l10n) {
  final lower = errorStr.toLowerCase();
  if (lower.contains('429') || lower.contains('too many requests')) {
    return 'Слишком много запросов. Подождите минуту и попробуйте снова.';
  }
  if (lower.contains('422') || lower.contains('unprocessable')) {
    return 'Некорректный формат сообщения.';
  }
  if (lower.contains('timeout')) {
    return 'Время ожидания истекло. Попробуйте позже.';
  }
  if (lower.contains('connection') || lower.contains('socketexception')) {
    return 'Проблема с соединением. Проверьте интернет.';
  }
  return 'Ошибка: ${errorStr.split('\n').first.trim()}';
}

String _formatTime(DateTime ts) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final msgDay = DateTime(ts.year, ts.month, ts.day);

  if (msgDay == today) return DateFormat('HH:mm').format(ts);
  if (msgDay == today.subtract(const Duration(days: 1))) {
    return 'Вчера ${DateFormat('HH:mm').format(ts)}';
  }
  return DateFormat('dd.MM.yyyy HH:mm').format(ts);
}
