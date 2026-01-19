import 'package:inpo_mobile_app/core/data/datasources/remote/news_remote_data_source.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';

@LazySingleton(as: NewsRepository)
final class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  const NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<List<NewsItem>>> getNews(String path) async {
    try {
      final newsModels = await remoteDataSource.getNewsFromHtml(path);
      if (newsModels is DataFailed) return DataFailed(newsModels.error!);
      return DataSuccess(
          newsModels.data!.map((model) => model.toDomainEntity()).toList());
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
