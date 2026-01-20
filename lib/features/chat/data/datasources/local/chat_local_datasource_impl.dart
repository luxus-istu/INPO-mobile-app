import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';

@LazySingleton(as: ChatLocalDataSource)
final class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box<MessageModel> message_box;
  const ChatLocalDataSourceImpl(this.message_box);

  @override
  Future<DataState<List<MessageModel>>> getMessages() async {
    try {
      final messages = message_box.values.toList();

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return DataSuccess(messages);
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  @override
  Future<DataState<void>> saveMessage(MessageModel message) async {
    try {
      await this.message_box.add(message);
      return DataSuccess(await _checkAndRemoveOldItems());
    } catch (e) {
      return DataState.failure(Exception(e.toString()));
    }
  }

  Future<void> _checkAndRemoveOldItems() async {
    if (message_box.length < Constants.MAX_CHAT_HISTOY_LENGHT) return;

    final messages = await getMessages();
    if (messages is DataFailed) throw messages.error!;

    final itemsToRemove = messages.data!
        .take(message_box.length - Constants.MAX_CHAT_HISTOY_LENGHT)
        .toList();

    final keysToRemove = <int>[];
    final messageList = message_box.values.toList();

    for (final item in itemsToRemove) {
      final index = messageList.indexOf(item);
      if (index != -1) {
        keysToRemove.add(message_box.keys.elementAt(index));
      }
    }

    for (final key in keysToRemove) {
      await message_box.delete(key);
    }
  }
}
