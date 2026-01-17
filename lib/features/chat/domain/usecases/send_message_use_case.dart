import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart';

@lazySingleton
final class SendMessageUseCase {
  final ChatRepository repository;
  const SendMessageUseCase(this.repository);

  Stream<DataState<String>> call({void params}) async* {
    try {
      final aiResponseStream = repository.getAiResponse();

      await for (final dataState in aiResponseStream) {
        AppLogger.debug('AI Response data state: $dataState');
        yield dataState;
      }
    } catch (e) {
      AppLogger.error('Use case error: ${e.toString()}');
      yield DataFailed(Exception('Failed to get AI response: ${e.toString()}'));
    }
  }
}
