import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:equatable/equatable.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<NewsItem> news;

  const NewsLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}
