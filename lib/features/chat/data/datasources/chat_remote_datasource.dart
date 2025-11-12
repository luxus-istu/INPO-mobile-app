import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:remove_markdown/remove_markdown.dart';

abstract class ChatRemoteDataSource {
  Future<DataState<String>> sendMessage(List<MessageEntity> history);
}

@LazySingleton(as: ChatRemoteDataSource)
final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio client;
  ChatRemoteDataSourceImpl(this.client);

  @override
  Future<DataState<String>> sendMessage(List<MessageEntity> history) async {
    try {
      final response = await client.post(Constants.openRouterBaseUrl, data: {
        'model': Constants.model,
        'messages': history
            .map((msg) => {'role': msg.sender, 'content': msg.text})
            .toList(),
      });

      return DataSuccess(
          (response.data['choices'][0]['message']['content'] as String)
              .removeMarkdown());
    } catch (_) {
      return DataSuccess(Constants.AI_FRIENDLY_ERROR_MESSAGE);
    }
  }
}
