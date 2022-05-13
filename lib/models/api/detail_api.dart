import 'package:flutter_mini_project/models/detail.dart';
import 'package:flutter_mini_project/utils/api.dart';

class DetailAPI {
  final API _api = API();

  Future<Detail?> getDetailByKey(String key) async {
    try {
      var response = await _api.dio.get('/recipe/$key/');

      ResponseResultDetail responseResult =
          ResponseResultDetail.fromJson(response.data);

      return responseResult.results;
    } catch (e) {
      return Detail();
    }
  }
}
