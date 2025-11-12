import 'package:dio/dio.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/data/models/news_item_model.dart';
import 'package:html/parser.dart' as parser;
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';

abstract class NewsRemoteDataSource {
  Future<DataState<List<NewsItemModel>>> getNewsFromHtml();
}

@LazySingleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  const NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<DataState<List<NewsItemModel>>> getNewsFromHtml() async {
    try {
      final response = await dio.get(Constants.newsUrl);
      final document = parser.parse(response.data);

      final newsElements = document.querySelectorAll('div.mediaTileList-item');
      return DataSuccess(newsElements
          .map((element) => NewsItemModel.fromHtml(element))
          .toList());
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
