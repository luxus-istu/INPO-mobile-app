import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';

abstract class SpecialtyRepository {
  Future<List<Specialty>> getSpecialties();
}
