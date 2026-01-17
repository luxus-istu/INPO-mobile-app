import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/domain/entities/menu_item.dart';
import 'package:inpo_mobile_app/l10n/app_localizations.dart';

final class Constants {
  static const String AI_FRIENDLY_ERROR_MESSAGE =
      "Извините, я не могу обработать ваш запрос и дать вам ответ на вопрос. Уточните, либо напишите запрос по другому.";
  static const int MAX_CHAT_HISTOY_LENGHT = 50;
  static const String AI_API_BASE_URL =
      'https://api.mistral.ai/v1/agents/completions';

  static const String ISTU_BASE_URL = 'https://istu.ru';
  static const String NEWS_ISTU_URL = "$ISTU_BASE_URL/news/zhizn-universiteta";
  static const String SPECIALTIES_ISTU_URL =
      "$ISTU_BASE_URL/department/institut-nepreryvnogo-professionalnogo-obrazovaniya";

  static List<MenuItem> getMenuItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      MenuItem(Icons.person_outline, l10n.menuContacts, '/contacts'),
      MenuItem(Icons.newspaper_outlined, l10n.menuNews, '/news'),
      MenuItem(Icons.chat_bubble, l10n.menuChat, '/chat'),
      MenuItem(
          Icons.engineering_outlined, l10n.menuSpecialties, '/specialties'),
      MenuItem(Icons.home_outlined, l10n.menuHome, '/'),
    ];
  }
}
