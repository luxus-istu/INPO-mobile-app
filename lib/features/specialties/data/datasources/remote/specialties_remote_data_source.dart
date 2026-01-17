import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/data/models/specialty_model.dart';

abstract class SpecialtiesRemoteDataSource {
  Future<DataState<List<SpecialtyModel>>> getSpecialtiesFromHtml();
}
