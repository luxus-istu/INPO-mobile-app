import 'package:dio/dio.dart';
import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/data/models/specialty_model.dart';
import 'package:html/parser.dart' as parser;
import 'package:injectable/injectable.dart';

abstract class SpecialtiesRemoteDataSource {
  Future<DataState<List<SpecialtyModel>>> getSpecialtiesFromHtml();
}

@LazySingleton(as: SpecialtiesRemoteDataSource)
class SpecialtiesRemoteDataSourceImpl implements SpecialtiesRemoteDataSource {
  final Dio dio;
  SpecialtiesRemoteDataSourceImpl(this.dio);

  @override
  Future<DataState<List<SpecialtyModel>>> getSpecialtiesFromHtml() async {
    try {
      final response = await dio.get(Constants.specialtiesUrl);
      final document = parser.parse(response.data);
      final listElement = document.querySelector(
          'div.tabcontrol-content[data-tab="abiturient"] ul.mainUseful-ul');

      if (listElement != null) {
        final specialtyElements =
            listElement.querySelectorAll('li.mainUseful-li');
        return DataSuccess(specialtyElements
            .map((element) => SpecialtyModel.fromHtml(element))
            .toList());
      }

      return DataSuccess([]);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
