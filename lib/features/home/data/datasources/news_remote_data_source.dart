import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/features/home/data/models/news_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:injectable/injectable.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsItemModel>> getNewsFromHtml();
}

@Singleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl();

  @override
  Future<List<NewsItemModel>> getNewsFromHtml() async {
    final response = await http.get(Uri.parse(Constants.newsUrl));

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final newsElements = document.querySelectorAll('div.mediaTileList-item');
      return newsElements
          .map((element) => NewsItemModel.fromHtml(element))
          .toList();
    } else {
      throw Exception(
          'Failed to load news. Status code: ${response.statusCode}');
    }
  }
}
