import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@lazySingleton
final class SendMessageUseCase extends UseCase<DataState<bool>, String> {
  final ChatRepository repository;
  SendMessageUseCase(this.repository);

  Future<DataState<bool>> call({String? params}) async {
    final history = await repository.getMessages();
    if (history is DataFailed) return DataFailed(history.error!);

    final newUserMessage = MessageEntity(
      text: params!,
      sender: 'user',
      timestamp: DateTime.now(),
    );
    history.data!.add(newUserMessage);

    var result = await repository.saveMessages(history.data!);
    if (result is DataFailed) return DataFailed(result.error!);

    final aiResponse = await repository.getAiResponse(history.data!);
    if (aiResponse is DataFailed) return DataFailed(aiResponse.error!);

    final newAiMessage = MessageEntity(
      text: aiResponse.data!,
      sender: 'assistant',
      timestamp: DateTime.now(),
    );
    history.data!.add(newAiMessage);

    result = await repository.saveMessages(history.data!);
    if (result is DataFailed) return DataFailed(result.error!);
    return DataSuccess(result.data!);
  }
}
