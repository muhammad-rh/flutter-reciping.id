import 'package:flutter_mini_project/models/search.dart';
import 'package:flutter_mini_project/utils/api.dart';

class SearchAPI {
  final API _api = API();

  Future<List<Search>> searchRecipeByKey(String key) async {
    try {
      var response = await _api.dio.get('/search/?q=$key');

      ResponseResultSearch responseResult =
          ResponseResultSearch.fromJson(response.data);

      List<Search> recipeList =
          responseResult.results!.map((e) => Search.fromJson(e)).toList();

      return recipeList;
    } catch (e) {
      return [];
    }
  }
}
