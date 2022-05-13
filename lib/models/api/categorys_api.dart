import 'package:flutter_mini_project/models/category.dart';
import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/utils/api.dart';

class CategorysAPI {
  final API _api = API();

  Future<List<Category>> getCategorys() async {
    try {
      var response = await _api.dio.get('/categorys/recipes/');

      // print('response: $response');

      ResponseResultCategorys responseResult =
          ResponseResultCategorys.fromJson(response.data);

      // print('responseResult: ${responseResult.results}');

      List<Category> categoryList =
          responseResult.results!.map((e) => Category.fromJson(e)).toList();

      return categoryList;
    } catch (e) {
      print('error1: $e');
      return [];
    }
  }

  Future<List<Recipe>> getCategoryList(String key, int page) async {
    try {
      var response = await _api.dio.get('/categorys/recipes/$key/$page');

      // print('response: $response');

      ResponseResultRecipe responseResult =
          ResponseResultRecipe.fromJson(response.data);

      // print('responseResult: ${responseResult.results}');

      List<Recipe> categoryList =
          responseResult.results!.map((e) => Recipe.fromJson(e)).toList();

      return categoryList;
    } catch (e) {
      print('error1: $e');
      return [];
    }
  }
}
