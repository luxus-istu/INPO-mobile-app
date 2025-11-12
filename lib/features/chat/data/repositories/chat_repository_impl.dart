import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@LazySingleton(as: ChatRepository)
final class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;
  ChatRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<DataState<List<MessageEntity>>> getMessages() async {
    final messageModels = await localDataSource.getLastMessages();
    if (messageModels is DataFailed) return DataFailed(messageModels.error!);
    return DataSuccess(
        messageModels.data!.map((model) => model as MessageEntity).toList());
  }

  @override
  Future<DataState<bool>> saveMessages(List<MessageEntity> messages) async {
    if (messages.length > Constants.MAX_CHAT_HISTOY_LENGHT) {
      messages =
          messages.sublist(messages.length - Constants.MAX_CHAT_HISTOY_LENGHT);
    }
    final List<MessageModel> messageModels = messages
        .map((messageEntity) => MessageModel.fromEntity(messageEntity))
        .toList();

    return await localDataSource.cacheMessages(messageModels);
  }

  @override
  Future<DataState<String>> getAiResponse(List<MessageEntity> history) async {
    return await remoteDataSource.sendMessage(history);
  }
}
