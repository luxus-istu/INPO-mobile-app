part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final String newsType;
  const FetchNews({this.newsType = ""});

  @override
  List<Object> get props => [this.newsType];
}
