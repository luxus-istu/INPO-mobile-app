import 'package:equatable/equatable.dart';

final class NewsItem extends Equatable {
  final String? title;
  final String? date;
  final String? imageUrl;
  final String? link;

  const NewsItem({
    this.title,
    this.date,
    this.imageUrl,
    this.link,
  });

  @override
  List<Object?> get props => [
        this.title,
        this.date,
        this.imageUrl,
        this.link,
      ];
}
