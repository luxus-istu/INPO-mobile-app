import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';
import 'package:remove_markdown/remove_markdown.dart';

@LazySingleton(as: ChatRemoteDataSource)
final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio client;
  const ChatRemoteDataSourceImpl(this.client);

  @override
  Stream<DataState<String>> sendMessage(List<MessageEntity> history) async* {
    try {
      final messages = history.map((e) => e.toJson()).toList();
      final response = await client.post(Constants.AI_API_BASE_URL,
          data: {
            'stream': true,
            'agent_id': dotenv.get("AI_AGENT_ID"),
            'messages': messages,
          },
          options: Options(
              responseType: ResponseType.stream,
              headers: {'Accept': 'text/event-stream'}));

      if (response.data is! ResponseBody) {
        yield DataState<String>.failure(
            Exception('Ожидался потоковый ответ от сервера'));
        return;
      }

      final ResponseBody responseBody = response.data;
      final Stream<List<int>> stream = responseBody.stream;
      String buffer = '';

      // Add timeout to prevent hanging streams
      final timeoutDuration = const Duration(minutes: 2);
      final timeout = Timer(timeoutDuration, () {
        throw TimeoutException(
            'Stream timeout after ${timeoutDuration.inMinutes} minutes');
      });

      try {
        await for (final chunk in stream) {
          final chunkString = utf8.decode(chunk);
          buffer += chunkString;

          final lines = buffer.split('\n');

          for (final line in lines) {
            if (line.startsWith('data: ')) {
              final data = line.substring(6);

              if (data == '[DONE]') {
                continue;
              }

              if (data.trim().isNotEmpty) {
                try {
                  final jsonData = json.decode(data);
                  final textChunk = _extractTextFromJson(jsonData);

                  if (textChunk.isNotEmpty) {
                    yield DataState.success(textChunk.removeMarkdown());
                  }
                } catch (e) {
                  AppLogger.error('Ошибка парсинга чанка: $e');
                  yield DataState.failure(
                      Exception('Ошибка парсинга ответа ИИ: ${e.toString()}'));
                  return;
                }
              }
            }
          }

          buffer = lines.last;
        }
      } catch (e) {
        AppLogger.error('Remote data source error: ${e.toString()}');

        // Handle rate limiting specifically
        if (e.toString().contains('429') ||
            e.toString().contains('Too Many Requests')) {
          yield DataState.failure(Exception(
              'Rate limit exceeded: Too many requests to AI service. Please wait and try again.'));
        }
        // Handle unprocessable entity (422)
        else if (e.toString().contains('422') ||
            e.toString().contains('Unprocessable Entity')) {
          yield DataState.failure(Exception(
              'Unprocessable entity: Invalid request format or content.'));
        } else {
          yield DataState.failure(
              Exception('Failed to get AI response: ${e.toString()}'));
        }
      } finally {
        timeout.cancel();
      }
    } catch (e) {
      AppLogger.error('Remote data source error: ${e.toString()}');

      // Handle rate limiting specifically
      if (e.toString().contains('429') ||
          e.toString().contains('Too Many Requests')) {
        yield DataState.failure(Exception(
            'Rate limit exceeded: Too many requests to AI service. Please wait and try again.'));
      }
      // Handle unprocessable entity (422)
      else if (e.toString().contains('422') ||
          e.toString().contains('Unprocessable Entity')) {
        yield DataState.failure(Exception(
            'Unprocessable entity: Invalid request format or content.'));
      } else {
        yield DataState.failure(
            Exception('Failed to get AI response: ${e.toString()}'));
      }
    }
  }

  String _extractTextFromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('choices') && json['choices'].isNotEmpty) {
        final delta = json['choices'][0]['delta'];
        if (delta != null && delta.containsKey('content')) {
          return delta['content'] ?? '';
        }
      }

      if (json.containsKey('completion')) {
        return json['completion'] ?? '';
      }

      return json['text'] ?? json['content'] ?? '';
    } catch (e) {
      return '';
    }
  }

  // @override
  // Future<DataState<String>> sendMessage(List<MessageEntity> history) async {
  //   try {
  //     final response = await client.post(Constants.AI_API_BASE_URL, data: {
  //       'agent_id': dotenv.get("AI_AGENT_ID"),
  //       'messages': history
  //           .map((msg) => {'role': msg.sender, 'content': msg.text})
  //           .toList(),
  //     });

  //     return DataSuccess(
  //         (response.data['choices'][0]['message']['content'] as String)
  //             .removeMarkdown());
  //   } catch (_) {
  //     return DataSuccess(Constants.AI_FRIENDLY_ERROR_MESSAGE);
  //   }
  // }
}
