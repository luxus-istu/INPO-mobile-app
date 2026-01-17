import 'package:inpo_mobile_app/core/data/models/news_item_model.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';

abstract interface class NewsRemoteDataSource {
  Future<DataState<List<NewsItemModel>>> getNewsFromHtml();
}
