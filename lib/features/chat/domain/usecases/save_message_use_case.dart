import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@lazySingleton
final class SaveMessageUseCase
    implements UseCase<DataState<void>, MessageEntity> {
  final ChatRepository chatRepository;
  const SaveMessageUseCase(this.chatRepository);

  @override
  Future<DataState<void>> call({MessageEntity? params}) async {
    try {
      return await chatRepository.saveMessage(params!);
    } catch (e) {
      return DataState.failure(Exception(e.toString()));
    }
  }
}
