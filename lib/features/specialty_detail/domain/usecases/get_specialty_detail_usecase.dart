import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/specialty_detail/domain/entities/specialty_detail.dart';
import 'package:inpo_mobile_app/features/specialty_detail/domain/repositories/specialty_detail_repository.dart';

@lazySingleton
class GetSpecialtyDetailUseCase extends UseCase<SpecialtyDetail, String> {
  final SpecialtyDetailRepository _repository;

  GetSpecialtyDetailUseCase(this._repository);

  Future<SpecialtyDetail> call({String? params}) async {
    return await _repository.getSpecialtyDetail(params!);
  }
}
