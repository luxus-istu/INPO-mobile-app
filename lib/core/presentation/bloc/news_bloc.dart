import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/domain/usecases/get_news_usecase.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:injectable/injectable.dart';

part 'news_event.dart';
part 'news_state.dart';

@lazySingleton
final class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(this._getNewsUseCase) : super(const NewsInitial()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());
    try {
      final news = await this._getNewsUseCase(params: event.newsType);
      if (news is DataFailed) {
        emit(NewsError(news.error!));
        return;
      }
      emit(NewsLoaded(news.data!));
    } on Exception catch (e) {
      emit(NewsError(Exception('Failed to fetch news: ${e.toString()}')));
    }
  }
}
