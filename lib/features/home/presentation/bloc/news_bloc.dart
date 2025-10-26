import 'package:bloc/bloc.dart';
import 'package:inpo_mobile_app/features/home/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/features/home/domain/usecases/get_news_usecase.dart';
import 'package:injectable/injectable.dart';

import 'news_event.dart';
import 'news_state.dart';

@lazySingleton
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(this._getNewsUseCase) : super(const NewsInitial()) {
    on<FetchNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());
    try {
      final List<NewsItem> news = await this._getNewsUseCase();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
