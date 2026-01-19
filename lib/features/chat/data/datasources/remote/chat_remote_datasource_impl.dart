import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:inpo_mobile_app/features/chat/domain/entities/message_entity.dart';

@LazySingleton(as: ChatRemoteDataSource)
final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio client;

  const ChatRemoteDataSourceImpl(this.client);

  @override
  Stream<DataState<String>> sendMessage(List<MessageEntity> history) async* {
    try {
      // AppLogger.debug('Sending to Mistral Agents:');
      // AppLogger.debug('URL: ${Constants.AI_API_BASE_URL}');
      // AppLogger.debug('Body: ${jsonEncode({
      //       'stream': true,
      //       'agent_id': dotenv.get("AI_AGENT_ID"),
      //       'messages': history.map((e) => e.toJson()).toList(),
      //     })}');

      final response = await client.post(
        Constants
            .AI_API_BASE_URL, // should be "https://api.mistral.ai/v1/agents/completions"
        data: {
          'agent_id': dotenv.env['AI_AGENT_ID']!,
          'messages': history.map((e) => e.toJson()).toList(),
          'stream': true,
        },
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
          },
          receiveTimeout: const Duration(minutes: 4),
          sendTimeout: const Duration(seconds: 60),
        ),
      );

      if (response.data is! ResponseBody) {
        yield DataState.failure(Exception('Ожидался потоковый ответ'));
        return;
      }

      final stream = (response.data as ResponseBody).stream;

      final buffer = StringBuffer();
      String? currentEvent;

      await for (final chunk in stream) {
        buffer.write(utf8.decode(chunk));

        final data = buffer.toString();
        final lines = data.split('\n');

        // Обрабатываем все полные строки, последнюю (возможно неполную) оставляем в буфере
        for (var i = 0; i < lines.length - 1; i++) {
          final line = lines[i].trim();

          if (line.isEmpty) continue;

          if (line.startsWith('event: ')) {
            currentEvent = line.substring(7).trim();
            continue;
          }

          if (line.startsWith('data: ')) {
            final payload = line.substring(6).trim();

            if (payload == '[DONE]') {
              return; // нормальное завершение стрима
            }

            if (payload.isNotEmpty) {
              final text = _parseContent(payload, currentEvent);
              if (text.isNotEmpty) {
                yield DataState.success(text);
              }
            }
          }
        }

        // Остаток (неполная строка) сохраняем
        buffer.clear();
        if (lines.isNotEmpty) {
          buffer.write(lines.last);
        }
      }

      // Если стрим завершился без [DONE]
      if (buffer.isNotEmpty) {
        AppLogger.warning(
            'Stream ended without [DONE], leftover: ${buffer.length} chars');
      }
    } on DioException catch (e) {
      yield _mapDioErrorToFailure(e);
    } on TimeoutException {
      yield DataState.failure(
          Exception('Превышено время ожидания ответа от ИИ'));
    } catch (e, stack) {
      AppLogger.error('Unexpected streaming error', e, stack);
      yield DataState.failure(Exception('Ошибка соединения с ИИ: $e'));
    }
  }

  String _parseContent(String rawData, String? eventType) {
    try {
      final json = jsonDecode(rawData) as Map<String, dynamic>;

      // Вариант 1 — самый распространённый (OpenAI-совместимый)
      if (json['choices'] != null) {
        final choice = (json['choices'] as List).firstOrNull as Map?;
        final delta = choice?['delta'] as Map?;
        return delta?['content'] as String? ?? '';
      }

      // Вариант 2 — Anthropic / некоторые кастомные
      if (json['type'] == 'content_block_delta') {
        return json['delta']?['text'] as String? ?? '';
      }

      // Вариант 3 — прямой текст
      return json['content'] as String? ??
          json['text'] as String? ??
          json['completion'] as String? ??
          '';
    } catch (_) {
      // Если не JSON — возможно просто текст (некоторые старые бэкенды)
      return rawData;
    }
  }

  DataState<String> _mapDioErrorToFailure(DioException e) {
    final status = e.response?.statusCode;

    return switch (status) {
      429 => DataState.failure(Exception(
          'Слишком много запросов. Подождите минуту и попробуйте снова.')),
      422 => DataState.failure(
          Exception('Некорректный формат сообщения или параметров.')),
      401 =>
        DataState.failure(Exception('Ошибка авторизации. Проверьте API ключ.')),
      400 => DataState.failure(Exception(
          'Неверный запрос: ${e.response?.data?['error']?['message'] ?? e.message}')),
      _ => DataState.failure(
          Exception('Сетевая ошибка: ${e.message}'),
        ),
    };
  }
}
