import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty_detail.dart';

abstract class SpecialtyDetailRepository {
  Future<SpecialtyDetail> getSpecialtyDetail(String url);
}
