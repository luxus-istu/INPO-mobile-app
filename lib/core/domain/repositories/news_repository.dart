import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getNews();
}
