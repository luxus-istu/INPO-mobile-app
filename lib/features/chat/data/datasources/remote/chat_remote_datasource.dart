import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

abstract interface class ChatRemoteDataSource {
  Stream<DataState<String>> sendMessage(List<MessageEntity> history);
}
