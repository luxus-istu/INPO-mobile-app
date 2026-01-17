import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/data/datasources/remote/specialty_detail_remote_data_source.dart';
import 'package:inpo_mobile_app/features/specialties/data/models/specialty_detail_model.dart';

@LazySingleton(as: SpecialtyDetailRemoteDataSource)
class SpecialtyDetailRemoteDataSourceImpl
    implements SpecialtyDetailRemoteDataSource {
  final Dio dio;
  SpecialtyDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<DataState<SpecialtyDetailModel>> getSpecialtyDetailFromUrl(
      String url) async {
    try {
      final response = await dio.get(url);
      return DataSuccess(SpecialtyDetailModel.fromHtml(response.data, url));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
