import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNewsUseCase extends UseCase<DataState<List<NewsItem>>, void> {
  final NewsRepository _repository;
  GetNewsUseCase(this._repository);

  @override
  Future<DataState<List<NewsItem>>> call({void params}) async {
    return await _repository.getNews();
  }
}
