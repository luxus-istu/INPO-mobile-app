import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';

abstract class SpecialtyDetailRepository {
  Future<DataState<SpecialtyDetail>> getSpecialtyDetail(String url);
}
