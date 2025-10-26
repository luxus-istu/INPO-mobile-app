import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:inpo_mobile_app/features/specialty_detail/data/models/specialty_detail_model.dart';

abstract class SpecialtyDetailRemoteDataSource {
  Future<SpecialtyDetailModel> getSpecialtyDetailFromUrl(String url);
}

@LazySingleton(as: SpecialtyDetailRemoteDataSource)
class SpecialtyDetailRemoteDataSourceImpl
    implements SpecialtyDetailRemoteDataSource {
  const SpecialtyDetailRemoteDataSourceImpl();

  @override
  Future<SpecialtyDetailModel> getSpecialtyDetailFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SpecialtyDetailModel.fromHtml(response.body, url);
    } else {
      throw Exception('Failed to load specialty detail');
    }
  }
}
