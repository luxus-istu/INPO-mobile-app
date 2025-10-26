import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/features/specialty_detail/domain/usecases/get_specialty_detail_usecase.dart';
import 'specialty_detail_event.dart';
import 'specialty_detail_state.dart';

@lazySingleton
class SpecialtyDetailBloc
    extends Bloc<SpecialtyDetailEvent, SpecialtyDetailState> {
  final GetSpecialtyDetailUseCase _getSpecialtyDetailUseCase;

  SpecialtyDetailBloc(this._getSpecialtyDetailUseCase)
      : super(const SpecialtyDetailInitial()) {
    on<FetchSpecialtyDetail>(_onFetchSpecialtyDetail);
  }

  Future<void> _onFetchSpecialtyDetail(
      FetchSpecialtyDetail event, Emitter<SpecialtyDetailState> emit) async {
    emit(const SpecialtyDetailLoading());
    try {
      final detail = await _getSpecialtyDetailUseCase.call(params: event.url);
      emit(SpecialtyDetailLoaded(detail));
    } catch (e) {
      emit(SpecialtyDetailError(e.toString()));
    }
  }
}
