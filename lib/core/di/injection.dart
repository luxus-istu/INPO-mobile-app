import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart';
import 'package:inpo_mobile_app/hive_registrar.g.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await dotenv.load();

  await Hive.initFlutter();
  Hive.registerAdapters();

  getIt.registerSingleton<Box<MessageModel>>(
      await Hive.openBox<MessageModel>('messages'));

  getIt.registerSingleton<Dio>(Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.get("AI_API_KEY")}',
    },
  )));

  getIt.init();
}
