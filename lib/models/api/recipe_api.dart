import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/utils/api.dart';

class RecipeAPI {
  final API _api = API();

  Future<List<Recipe>> getRecipeByPage(int page) async {
    try {
      var response = await _api.dio.get(
        '/recipes/',
        queryParameters: {
          'page': page,
        },
      );

      ResponseResultRecipe responseResult =
          ResponseResultRecipe.fromJson(response.data);

      List<Recipe> recipeList =
          responseResult.results!.map((e) => Recipe.fromJson(e)).toList();

      return recipeList;
    } catch (e) {
      return [];
    }
  }
}
