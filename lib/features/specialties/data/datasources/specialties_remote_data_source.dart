import 'package:inpo_mobile_app/core/constants/constants.dart';
import 'package:inpo_mobile_app/features/specialties/data/models/specialty_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:injectable/injectable.dart';

abstract class SpecialtiesRemoteDataSource {
  Future<List<SpecialtyModel>> getSpecialtiesFromHtml();
}

@LazySingleton(as: SpecialtiesRemoteDataSource)
class SpecialtiesRemoteDataSourceImpl implements SpecialtiesRemoteDataSource {
  const SpecialtiesRemoteDataSourceImpl();

  @override
  Future<List<SpecialtyModel>> getSpecialtiesFromHtml() async {
    final response = await http.get(Uri.parse(Constants.specialtiesUrl));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final listElement = document.querySelector(
          'div.tabcontrol-content[data-tab="abiturient"] ul.mainUseful-ul');

      if (listElement != null) {
        final specialtyElements =
            listElement.querySelectorAll('li.mainUseful-li');
        return specialtyElements
            .map((element) => SpecialtyModel.fromHtml(element))
            .toList();
      }

      return [];
    } else {
      throw Exception(
          'Failed to load specialties. Status code: ${response.statusCode}');
    }
  }
}
