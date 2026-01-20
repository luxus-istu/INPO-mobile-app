import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';

abstract interface class ChatLocalDataSource {
  Future<DataState<List<MessageModel>>> getMessages();
  Future<DataState<void>> saveMessage(MessageModel message);
}
