import 'package:inpo_mobile_app/core/usecases/usecase.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSpecialtiesUseCase extends UseCase<List<Specialty>, void> {
  final SpecialtyRepository _repository;

  GetSpecialtiesUseCase(this._repository);

  Future<List<Specialty>> call({void params}) async {
    return await _repository.getSpecialties();
  }
}
