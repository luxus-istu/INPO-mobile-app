import 'package:bloc/bloc.dart';
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialties_usecase.dart';
import 'package:injectable/injectable.dart';

import 'specialty_event.dart';
import 'specialty_state.dart';

@lazySingleton
class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  final GetSpecialtiesUseCase _getSpecialtiesUseCase;

  SpecialtyBloc({required GetSpecialtiesUseCase getSpecialtiesUseCase})
      : _getSpecialtiesUseCase = getSpecialtiesUseCase,
        super(const SpecialtyInitial()) {
    on<FetchSpecialties>(_onFetchSpecialties);
  }

  Future<void> _onFetchSpecialties(
      FetchSpecialties event, Emitter<SpecialtyState> emit) async {
    emit(const SpecialtyLoading());
    try {
      final specialties = await _getSpecialtiesUseCase();
      emit(SpecialtyLoaded(specialties));
    } catch (e) {
      emit(SpecialtyError(e.toString()));
    }
  }
}
