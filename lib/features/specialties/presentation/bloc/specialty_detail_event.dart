import 'package:equatable/equatable.dart';

abstract class SpecialtyDetailEvent extends Equatable {
  const SpecialtyDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchSpecialtyDetail extends SpecialtyDetailEvent {
  final String url;
  const FetchSpecialtyDetail(this.url);
  @override
  List<Object> get props => [url];
}
