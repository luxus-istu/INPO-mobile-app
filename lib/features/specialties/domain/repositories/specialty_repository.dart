import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';

abstract class SpecialtyRepository {
  Future<DataState<List<Specialty>>> getSpecialties();
}
