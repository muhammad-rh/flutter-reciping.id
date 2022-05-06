import 'package:flutter_mini_project/models/categorys.dart';
import 'package:flutter_mini_project/utils/api.dart';

class CategorysAPI {
  final API _api = API();

  Future<List<Categorys>> getCategorysByKey(String key) async {
    try {
      var response = await _api.dio.get(
        '/recipes/',
        queryParameters: {
          'categorys': key,
        },
      );

      print('response: $response');

      ResponseResultCategorys responseResult =
          ResponseResultCategorys.fromJson(response.data);

      print('responseResult: ${responseResult.results}');

      List<Categorys> categoryList =
          responseResult.results!.map((e) => Categorys.fromJson(e)).toList();

      return categoryList;
    } catch (e) {
      print('error1: $e');
      return [];
    }
  }
}
