import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@lazySingleton
final class GetMessagesUseCase
    implements UseCase<DataState<List<MessageEntity>>, void> {
  final ChatRepository repository;
  const GetMessagesUseCase(this.repository);

  Future<DataState<List<MessageEntity>>> call({void params}) async {
    return await repository.getMessages();
  }
}
