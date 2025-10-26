import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/features/home/domain/entities/news_item.dart';

class NewsItemModel {
  final String? title;
  final String? date;
  final String? imageUrl;
  final String? link;

  const NewsItemModel({
    this.title,
    this.date,
    this.imageUrl,
    this.link,
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
        imageUrl = '${Constants.baseUrl}$imageSrc';
      } else {
        imageUrl = imageSrc;
      }
    }

    final relativeLink = titleElement?.attributes['href'] ?? '';
    final link = relativeLink.startsWith('http')
        ? relativeLink
        : '${Constants.baseUrl}$relativeLink';

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
}
