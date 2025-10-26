import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:inpo_mobile_app/presentation/helpers/specialty_icon_mapper.dart';
import 'package:inpo_mobile_app/features/specialty_detail/domain/entities/specialty_detail.dart';

class SpecialtyDetailModel {
  final String? title;
  final String? description;
  final String? seats;
  final String? duration;
  final List<String>? companies;
  final List<String>? disciplines;
  final List<String>? competencies;
  final String? code;
  final String? link;

  const SpecialtyDetailModel({
    this.title,
    this.description,
    this.seats,
    this.duration,
    this.companies,
    this.disciplines,
    this.competencies,
    this.code,
    this.link,
  });

  factory SpecialtyDetailModel.fromHtml(String html, String link) {
    final document = parser.parse(html);
    final programContainer = document.querySelector('div.program-inner');

    if (programContainer == null) return SpecialtyDetailModel();

    return SpecialtyDetailModel(
      link: link,
      title: _extractTitle(document, programContainer),
      description: _extractDescription(programContainer),
      seats: _extractSeats(programContainer),
      duration: _extractDuration(programContainer),
      companies: _extractCompanies(programContainer),
      disciplines: _extractDisciplines(programContainer),
      competencies:
          _extractCompetencies(programContainer), // Извлекаем компетенции
      code: _extractCode(programContainer), // Извлекаем код специальности
    );
  }

  static String? _extractTitle(Document document, Element programContainer) {
    // Из заголовка страницы
    final pageTitle = document.querySelector('title')?.text ?? '';
    final titleMatch =
        RegExp(r'\d{2}\.\d{2}\.\d{2}\s+(.+?)\s+-').firstMatch(pageTitle);
    if (titleMatch != null) return titleMatch.group(1)!.trim();

    // Из основного заголовка
    final headerTitle =
        document.querySelector('.bachelorHeader-title')?.text.trim();
    if (headerTitle?.isNotEmpty == true) return headerTitle;

    // Из таблицы специальности
    final specialtyCell =
        _findTableCellByText(programContainer, 'Специальность:');
    if (specialtyCell != null) {
      final fullText = specialtyCell.text.trim();
      final codeMatch =
          RegExp(r'\d{2}\.\d{2}\.\d{2}\s+(.+)').firstMatch(fullText);
      return codeMatch?.group(1)?.trim() ??
          (fullText.length > 10 ? fullText.substring(10).trim() : fullText);
    }

    return null;
  }

  static String? _extractCode(Element programContainer) {
    final specialtyCell =
        _findTableCellByText(programContainer, 'Специальность:');
    if (specialtyCell != null) {
      final fullText = specialtyCell.text.trim();
      // Извлекаем код специальности (формат XX.XX.XX)
      final codeMatch = RegExp(r'(\d{2}\.\d{2}\.\d{2})').firstMatch(fullText);
      return codeMatch?.group(1);
    }
    return null;
  }

  static String? _extractDescription(Element programContainer) {
    final header = _findElementByExactText(
        programContainer, 'Описание образовательной программы');
    return _getNextDivContent(header);
  }

  static String? _extractSeats(Element programContainer) {
    final tables = programContainer.querySelectorAll('table');
    for (var table in tables) {
      for (var row in table.querySelectorAll('tr')) {
        final cells = row.querySelectorAll('td');
        if (cells.length >= 2) {
          final label = cells[0].text.trim();
          if (label.contains('Платных') && label.contains('очно')) {
            return cells[1].text.trim();
          }
        }
      }
    }
    return null;
  }

  static String? _extractDuration(Element programContainer) {
    // Поиск в основной таблице
    final formCell = _findTableCellByText(programContainer, 'Форма обучения:');
    if (formCell != null) {
      final formText = formCell.text.trim();
      return formText.contains(',')
          ? formText.split(',').last.trim()
          : formText;
    }

    // Поиск в flex-контейнерах
    final flexContainers =
        programContainer.querySelectorAll('div[style*="display: flex"]');
    for (var container in flexContainers) {
      for (var column in container.querySelectorAll('div')) {
        final header = column.querySelector('div');
        if (header?.text.contains('Форма обучения:') == true) {
          final contentDiv = column
              .querySelectorAll('div')
              .where((d) => d != header)
              .firstOrNull;
          final formText = contentDiv?.text.trim() ?? '';
          return formText.contains(',')
              ? formText.split(',').last.trim()
              : formText;
        }
      }
    }

    return null;
  }

  static List<String>? _extractDisciplines(Element programContainer) {
    final header = _findElementByExactText(programContainer, 'Дисциплины');
    final contentDiv = _getNextDivElement(header);
    if (contentDiv == null) return null;

    return contentDiv
        .querySelectorAll('li')
        .map((e) => e.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static List<String>? _extractCompetencies(Element programContainer) {
    final header =
        _findElementByExactText(programContainer, 'Получаемые компетенции');
    final contentDiv = _getNextDivElement(header);
    if (contentDiv == null) return null;

    return contentDiv
        .querySelectorAll('li')
        .map((e) => e.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static List<String>? _extractCompanies(Element programContainer) {
    final header = _findElementByExactText(programContainer, 'Трудоустройство');
    final content = _getNextDivContent(header);
    if (content?.isEmpty != false) return null;

    return content!
        .split(';')
        .map((company) => company.trim())
        .where((company) => company.isNotEmpty)
        .toList();
  }

  // Вспомогательные методы
  static Element? _findElementByExactText(Element container, String text) {
    final elements = container.querySelectorAll('div');
    for (var element in elements) {
      if (element.text.trim() == text) {
        return element;
      }
    }
    return null;
  }

  static Element? _findTableCellByText(Element container, String text) {
    final cells = container.querySelectorAll('td');
    for (var cell in cells) {
      if (cell.text.trim().contains(text)) {
        final row = cell.parent;
        final rowCells = row?.querySelectorAll('td') ?? [];
        return rowCells.length >= 2 ? rowCells[1] : null;
      }
    }
    return null;
  }

  static String? _getNextDivContent(Element? header) {
    final div = _getNextDivElement(header);
    return div?.text.trim();
  }

  static Element? _getNextDivElement(Element? header) {
    if (header == null) return null;

    Element? current = header.nextElementSibling;
    while (current != null) {
      if (current.localName == 'div') return current;
      current = current.nextElementSibling;
    }
    return null;
  }

  SpecialtyDetail toDomainEntity() {
    return SpecialtyDetail(
        link: link,
        title: title,
        description: description,
        seats: seats,
        duration: duration,
        companies: companies,
        disciplines: disciplines,
        competencies: competencies, // Добавляем компетенции
        code: code, // Добавляем код специальности
        icon: SpecialtyIconMapper.getIconForCode(code!));
  }
}
