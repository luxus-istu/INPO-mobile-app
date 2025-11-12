import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatLocalDataSource {
  Future<DataState<List<MessageModel>>> getLastMessages();
  Future<DataState<bool>> cacheMessages(List<MessageModel> messages);
}

@LazySingleton(as: ChatLocalDataSource)
class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final SharedPreferences sharedPreferences;
  ChatLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<DataState<List<MessageModel>>> getLastMessages() async {
    try {
      final jsonStrings = sharedPreferences.getStringList('chat_history') ?? [];
      return DataSuccess(jsonStrings
          .map((jsonString) => MessageModel.fromJson(json.decode(jsonString)))
          .toList());
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> cacheMessages(List<MessageModel> messages) async {
    try {
      final List<String> jsonStrings =
          messages.map((message) => json.encode(message.toJson())).toList();
      return DataSuccess(
          await sharedPreferences.setStringList('chat_history', jsonStrings));
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
