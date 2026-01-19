import 'package:dio/dio.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/data/datasources/remote/news_remote_data_source.dart';
import 'package:inpo_mobile_app/core/data/models/news_item_model.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/utils/error_handler.dart';
import 'package:html/parser.dart' as parser;
import 'package:injectable/injectable.dart';

@LazySingleton(as: NewsRemoteDataSource)
final class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  const NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<DataState<List<NewsItemModel>>> getNewsFromHtml(String path) async {
    try {
      final response = await dio.get(Constants.ISTU_BASE_NEWS_URL + path);
      final document = parser.parse(response.data);

      final newsElements = document.querySelectorAll('div.mediaTileList-item');

      if (newsElements.isEmpty) {
        return DataSuccess([]);
      }

      return DataSuccess(newsElements
          .map((element) => NewsItemModel.fromHtml(element))
          .toList());
    } on DioException catch (e) {
      final error = ErrorHandler.handleDioError(e);
      return DataFailed(error);
    } catch (e) {
      final error = ErrorHandler.handleParsingError(
          e, 'NewsRemoteDataSource.getNewsFromHtml');
      return DataFailed(error);
    }
  }
}
