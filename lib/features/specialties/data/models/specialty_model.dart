import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/core/presentation/helpers/specialty_icon_mapper.dart';

class SpecialtyModel {
  final String? code;
  final String? title;
  final String? formOfEducation;
  final String? link;

  const SpecialtyModel({
    this.code,
    this.title,
    this.formOfEducation,
    this.link,
  });

  factory SpecialtyModel.fromHtml(var element) {
    final linkElement = element.querySelector('a.link.animation');
    final fullText = linkElement?.text?.trim() ?? '';
    final link = linkElement?.attributes['href'] ?? '';

    final regex = RegExp(
      r'^(\d{2}\.\d{2}\.\d{2})\s*«([^»]+)»\s*«[^»]+»\s*(?:\(([^)]+)\))?$',
    );
    final match = regex.firstMatch(fullText);

    String code = '';
    String title = fullText; // Fallback
    String formOfEducation = '';

    if (match != null) {
      code = match.group(1) ?? '';
      title = match.group(2) ?? '';
      formOfEducation = match.group(3) ?? '';
    }

    return SpecialtyModel(
      code: code,
      title: title,
      formOfEducation: formOfEducation,
      link: link,
    );
  }

  Specialty toDomainEntity() {
    return Specialty(
        code: code,
        title: title,
        formOfEducation: formOfEducation,
        link: link,
        icon: SpecialtyIconMapper.getIconForCode(code!));
  }
}
