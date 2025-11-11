part of 'specialty_detail_bloc.dart';

sealed class SpecialtyDetailState extends Equatable {
  const SpecialtyDetailState();
  @override
  List<Object> get props => [];
}

class SpecialtyDetailInitial extends SpecialtyDetailState {
  const SpecialtyDetailInitial();
}

class SpecialtyDetailLoading extends SpecialtyDetailState {
  const SpecialtyDetailLoading();
}

class SpecialtyDetailLoaded extends SpecialtyDetailState {
  final SpecialtyDetail detail;
  const SpecialtyDetailLoaded(this.detail);
  @override
  List<Object> get props => [detail];
}

class SpecialtyDetailError extends SpecialtyDetailState {
  final String message;
  const SpecialtyDetailError(this.message);
  @override
  List<Object> get props => [message];
}
