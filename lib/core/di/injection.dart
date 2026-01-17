import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/utils/error_handler.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';
import 'package:inpo_mobile_app/hive_registrar.g.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  try {
    // Load environment variables
    await dotenv.load();
    AppLogger.info('Environment variables loaded successfully');

    // Initialize Hive database
    await Hive.initFlutter();
    Hive.registerAdapters();
    AppLogger.info('Hive database initialized successfully');

    // Register Hive box for messages
    final messagesBox = await Hive.openBox<MessageModel>('messages');
    getIt.registerSingleton<Box<MessageModel>>(messagesBox);
    AppLogger.info('Hive messages box registered successfully');

    // Configure Dio client with proper error handling
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.get("AI_API_KEY")}',
      },
    ));

    // Add interceptors for logging and error handling
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
      error: true,
    ));

    getIt.registerSingleton<Dio>(dio);
    AppLogger.info('Dio client configured successfully');

    // Initialize dependency injection
    getIt.init();
    AppLogger.info('Dependency injection initialized successfully');
  } catch (e, stackTrace) {
    final error = ErrorHandler.handleGeneralError(
        e, 'Dependency Injection Configuration');
    AppLogger.critical('Failed to configure dependencies: ${error.toString()}',
        error, stackTrace);
    rethrow;
  }
}
