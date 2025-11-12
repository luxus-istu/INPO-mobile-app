import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';

abstract class NewsRepository {
  Future<DataState<List<NewsItem>>> getNews();
}
