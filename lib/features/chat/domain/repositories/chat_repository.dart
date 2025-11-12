import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<DataState<List<MessageEntity>>> getMessages();
  Future<DataState<bool>> saveMessages(List<MessageEntity> messages);
  Future<DataState<String>> getAiResponse(List<MessageEntity> history);
}
