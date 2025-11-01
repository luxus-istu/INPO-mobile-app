import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/features/specialties/data/datasources/specialty_detail_remote_data_source.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_detail_repository.dart';

@LazySingleton(as: SpecialtyDetailRepository)
class SpecialtyDetailRepositoryImpl implements SpecialtyDetailRepository {
  final SpecialtyDetailRemoteDataSource remoteDataSource;

  SpecialtyDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<SpecialtyDetail> getSpecialtyDetail(String url) async {
    final detailModel = await remoteDataSource.getSpecialtyDetailFromUrl(url);
    return detailModel.toDomainEntity();
  }
}
