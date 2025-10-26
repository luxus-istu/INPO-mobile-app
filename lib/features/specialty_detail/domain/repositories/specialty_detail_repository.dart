import 'package:inpo_mobile_app/features/specialty_detail/domain/entities/specialty_detail.dart';

abstract class SpecialtyDetailRepository {
  Future<SpecialtyDetail> getSpecialtyDetail(String url);
}
