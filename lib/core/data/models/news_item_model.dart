import 'package:equatable/equatable.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';

final class NewsItemModel extends Equatable {
  final String title;
  final String date;
  final String? imageUrl;
  final String link;

  NewsItemModel({
    required this.title,
    required this.date,
    this.imageUrl,
    required this.link,
  });

  factory NewsItemModel.fromHtml(var element) {
    final titleElement = element.querySelector('a.mediaTile-caption');
    final title = titleElement?.text?.trim() ?? '';

    final dateElement = element.querySelector('div.mediaTile-date');
    final date = dateElement?.text?.trim() ?? '';

    final imageElement = element.querySelector('div.mediaTile-picture img');

    String? imageUrl;
    if (imageElement != null) {
      final imageSrc = imageElement.attributes['src'];
      if (imageSrc != null && imageSrc.startsWith('/')) {
        imageUrl = '${Constants.ISTU_BASE_URL}$imageSrc';
      } else {
        imageUrl = imageSrc;
      }
    }

    final relativeLink = titleElement?.attributes['href'] ?? '';
    final link = relativeLink.startsWith('http')
        ? relativeLink
        : '${Constants.ISTU_BASE_URL}$relativeLink';

    return NewsItemModel(
      title: title,
      date: date,
      imageUrl: imageUrl,
      link: link,
    );
  }

  NewsItem toDomainEntity() {
    return NewsItem(title: title, date: date, imageUrl: imageUrl, link: link);
  }

  @override
  List<Object?> get props => [
        this.title,
        this.date,
        this.imageUrl,
        this.link,
      ];
}
