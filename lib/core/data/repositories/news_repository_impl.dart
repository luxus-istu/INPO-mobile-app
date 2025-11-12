import 'package:inpo_mobile_app/core/data/datasources/news_remote_data_source.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DataState<List<NewsItem>>> getNews() async {
    try {
      final newsModels = await remoteDataSource.getNewsFromHtml();
      return DataSuccess(
          newsModels.data!.map((model) => model.toDomainEntity()).toList());
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }
}
