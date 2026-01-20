import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/local/chat_local_datasource.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@LazySingleton(as: ChatRepository)
final class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;
  const ChatRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<DataState<List<MessageEntity>>> getMessages() async {
    final messageModels = await localDataSource.getMessages();
    if (messageModels is DataFailed) return DataFailed(messageModels.error!);
    return DataSuccess(
        messageModels.data!.map((model) => model.toEntity()).toList());
  }

  @override
  Stream<DataState<String>> getAiResponse() async* {
    try {
      final messagesResult = await this.getMessages();

      if (messagesResult is DataFailed) {
        yield DataState.failure(messagesResult.error!);
        return;
      }

      yield* remoteDataSource.sendMessage(messagesResult.data!);
    } catch (e) {
      AppLogger.error('Repository error: ${e.toString()}');
      yield DataState.failure(Exception('Repository error: ${e.toString()}'));
    }
  }

  @override
  Future<DataState<void>> saveMessage(MessageEntity message) async {
    try {
      return await this
          .localDataSource
          .saveMessage(MessageModel.fromEntity(message));
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }
}
