import 'package:flutter/material.dart';

class SpecialtyIconMapper {
  const SpecialtyIconMapper._();
  static const Map<String, IconData> _iconMap = {
    '38.02.01': Icons.account_balance, // Экономика и бухгалтерский учет
    '15.02.04':
        Icons.precision_manufacturing, // Специальные машины и устройства
    '08.02.08': Icons.local_fire_department, // Монтаж... газоснабжения
    '25.02.08':
        Icons.flight_takeoff, // Эксплуатация беспилотных авиационных систем
    '38.02.07': Icons.attach_money, // Банковское дело
    '40.02.04': Icons.gavel, // Юриспруденция
    '38.02.08': Icons.shopping_cart, // Торговое дело
    '09.02.07': Icons.computer, // Информационные системы и программирование
    '54.02.01': Icons.palette, // Дизайн
    '12.02.10': Icons.biotech, // Монтаж... биотехнических...
    '38.02.03': Icons.local_shipping, // Операционная деятельность в логистике
    '15.02.17': Icons.factory, // Монтаж... промышленного оборудования
    '09.02.06': Icons.dns, // Сетевое и системное администрирование
  };

  static IconData getIconForCode(String code) {
    return _iconMap[code] ?? Icons.school; // Иконка по умолчанию
  }
}
