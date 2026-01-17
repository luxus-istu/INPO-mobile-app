import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/data/models/specialty_detail_model.dart';

abstract class SpecialtyDetailRemoteDataSource {
  Future<DataState<SpecialtyDetailModel>> getSpecialtyDetailFromUrl(String url);
}
