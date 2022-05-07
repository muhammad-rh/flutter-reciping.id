import 'package:flutter_mini_project/models/detail.dart';
import 'package:flutter_mini_project/utils/api.dart';

class DetailAPI {
  final API _api = API();

  Future<List<Detail>> getDetailByKey(String key) async {
    try {
      var response = await _api.dio.get(
        '/recipe/',
        queryParameters: {
          'key': key,
        },
      );

      print('response: $response');

      ResponseResultDetail responseResult =
          ResponseResultDetail.fromJson(response.data);

      print('responseResult: ${responseResult.results}');

      List<Detail> detailList = (responseResult.results as List)
          .map((e) => Detail.fromJson(e))
          .toList();

      return detailList;
    } catch (e) {
      print('error1: $e');
      return [];
    }
  }
}
