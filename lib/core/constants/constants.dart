import 'package:flutter/material.dart';
import 'package:inpo_mobile_app/core/domain/entities/menu_item.dart';

class Constants {
  static const String baseUrl = 'https://istu.ru';

  static const String newsUrl = "$baseUrl/news/zhizn-universiteta";

  static const String specialtiesUrl =
      "$baseUrl/department/institut-nepreryvnogo-professionalnogo-obrazovaniya";

  static const List<MenuItem> menuItems = [
    MenuItem(Icons.person_outline, 'Контакты', '/contacts'),
    MenuItem(Icons.newspaper_outlined, 'Новости', '/news'),
    MenuItem(Icons.engineering_outlined, 'Профессии', '/specialties'),
    MenuItem(Icons.home_outlined, 'Главная', '/'),
  ];
}
