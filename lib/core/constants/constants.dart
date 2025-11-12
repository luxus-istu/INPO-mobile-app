import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/domain/entities/menu_item.dart';

final class Constants {
  static const String AI_FRIENDLY_ERROR_MESSAGE =
      "Извините, я не могу обработать ваш запрос и дать вам ответ на вопрос. Уточните, либо напишите запрос по другому.";
  static const int MAX_CHAT_HISTOY_LENGHT = 5;
  static const String openRouterBaseUrl =
      'https://openrouter.ai/api/v1/chat/completions';
  static const String model = 'kwaipilot/kat-coder-pro:free';

  static const String baseUrl = 'https://istu.ru';
  static const String newsUrl = "$baseUrl/news/zhizn-universiteta";
  static const String specialtiesUrl =
      "$baseUrl/department/institut-nepreryvnogo-professionalnogo-obrazovaniya";

  static const List<MenuItem> menuItems = [
    MenuItem(Icons.person_outline, 'Контакты', '/contacts'),
    MenuItem(Icons.newspaper_outlined, 'Новости', '/news'),
    MenuItem(Icons.chat_bubble, 'ИИ-помошник', '/chat'),
    MenuItem(Icons.engineering_outlined, 'Профессии', '/specialties'),
    MenuItem(Icons.home_outlined, 'Главная', '/'),
  ];
}
