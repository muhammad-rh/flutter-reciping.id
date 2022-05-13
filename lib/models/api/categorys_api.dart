import 'package:flutter_mini_project/models/category.dart';
import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/utils/api.dart';

class CategorysAPI {
  final API _api = API();

  Future<List<Category>> getCategorys() async {
    try {
      var response = await _api.dio.get('/categorys/recipes/');

      ResponseResultCategorys responseResult =
          ResponseResultCategorys.fromJson(response.data);

      List<Category> categoryList =
          responseResult.results!.map((e) => Category.fromJson(e)).toList();

      return categoryList;
    } catch (e) {
      return [];
    }
  }

  Future<List<Recipe>> getCategoryList(String key, int page) async {
    try {
      var response = await _api.dio.get('/categorys/recipes/$key/$page');

      ResponseResultRecipe responseResult =
          ResponseResultRecipe.fromJson(response.data);

      List<Recipe> categoryList =
          responseResult.results!.map((e) => Recipe.fromJson(e)).toList();

      return categoryList;
    } catch (e) {
      return [];
    }
  }
}
