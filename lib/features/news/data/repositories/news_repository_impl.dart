import 'package:inpo_mobile_app/features/home/data/datasources/news_remote_data_source.dart';
import 'package:inpo_mobile_app/features/home/data/models/news_item_model.dart';
import 'package:inpo_mobile_app/features/home/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/features/home/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NewsItem>> getNews() async {
    final List<NewsItemModel> newsModels =
        await remoteDataSource.getNewsFromHtml();
    return newsModels.map((model) => model.toDomainEntity()).toList();
  }
}
