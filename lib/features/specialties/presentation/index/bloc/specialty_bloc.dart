import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialties_usecase.dart';
import 'package:injectable/injectable.dart';

part 'specialty_event.dart';
part 'specialty_state.dart';

@lazySingleton
final class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
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
      if (specialties is DataFailed) {
        return emit(SpecialtyError(specialties.error!));
      }
      emit(SpecialtyLoaded(specialties.data!));
    } on Exception catch (e) {
      return emit(SpecialtyError(e));
    }
  }
}
