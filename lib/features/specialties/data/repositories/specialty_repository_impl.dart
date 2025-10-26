import 'package:inpo_mobile_app/features/specialties/data/datasources/specialties_remote_data_source.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SpecialtyRepository)
class SpecialtyRepositoryImpl implements SpecialtyRepository {
  final SpecialtiesRemoteDataSource remoteDataSource;

  SpecialtyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Specialty>> getSpecialties() async {
    final specialtyModels = await remoteDataSource.getSpecialtiesFromHtml();
    return specialtyModels.map((model) => model.toDomainEntity()).toList();
  }
}
