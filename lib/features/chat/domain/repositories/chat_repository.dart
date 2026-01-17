import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

abstract interface class ChatRepository {
  Future<DataState<List<MessageEntity>>> getMessages();
  Future<DataState<void>> saveMessage(MessageEntity message);
  Stream<DataState<String>> getAiResponse();
}
