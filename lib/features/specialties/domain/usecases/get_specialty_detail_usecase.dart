import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_detail_repository.dart';

@lazySingleton
class GetSpecialtyDetailUseCase
    implements UseCase<DataState<SpecialtyDetail>, String> {
  final SpecialtyDetailRepository _repository;
  const GetSpecialtyDetailUseCase(this._repository);

  Future<DataState<SpecialtyDetail>> call({String? params}) async {
    return await _repository.getSpecialtyDetail(params!);
  }
}
