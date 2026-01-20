import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialty_detail_usecase.dart';

part 'specialty_detail_event.dart';
part 'specialty_detail_state.dart';

@lazySingleton
final class SpecialtyDetailBloc
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
      final detail = await _getSpecialtyDetailUseCase(params: event.url);
      if (detail is DataFailed) {
        return emit(SpecialtyDetailError(detail.error!));
      }
      emit(SpecialtyDetailLoaded(detail.data!));
    } on Exception catch (e) {
      emit(SpecialtyDetailError(e));
    }
  }
}
