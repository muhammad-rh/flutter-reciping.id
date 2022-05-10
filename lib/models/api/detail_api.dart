import 'dart:convert';

import 'package:flutter_mini_project/models/detail.dart';
import 'package:flutter_mini_project/utils/api.dart';

class DetailAPI {
  final API _api = API();

  Future<Detail?> getDetailByKey(String key) async {
    print('key: $key');
    try {
      var response = await _api.dio.get('/recipe/$key/');

      // print('response: ${response.data}');

      ResponseResultDetail responseResult =
          ResponseResultDetail.fromJson(response.data);

      // print('responseResult: ${responseResult.results}');

      return responseResult.results;
    } catch (e) {
      print('error1: $e');
      return Detail();
    }
  }
}
