import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/data/datasources/specialties_remote_data_source.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SpecialtyRepository)
class SpecialtyRepositoryImpl implements SpecialtyRepository {
  final SpecialtiesRemoteDataSource remoteDataSource;
  SpecialtyRepositoryImpl(this.remoteDataSource);

  @override
  Future<DataState<List<Specialty>>> getSpecialties() async {
    final specialtyModels = await remoteDataSource.getSpecialtiesFromHtml();
    if (specialtyModels is DataFailed)
      return DataFailed(specialtyModels.error!);
    return DataSuccess(
        specialtyModels.data!.map((model) => model.toDomainEntity()).toList());
  }
}
