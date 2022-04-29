import 'package:dio/dio.dart';
import 'package:flutter_mini_project/models/recipe_model.dart';
import 'package:flutter_mini_project/utils/api.dart';

class RecipeAPI {
  final API _api = API();

  Future<List<RecipeModel>> getRecipes() async {
    try {
      Response response = await _api.dio.get('/recipes');

      List<RecipeModel> recipeList = (response.data as List)
          .map(
            (e) => RecipeModel(
              title: e['title'],
              thumb: e['thumb'],
              key: e['key'],
              times: e['times'],
              portion: e['portion'],
              dificulty: e['dificulty'],
            ),
          )
          .toList();

      return recipeList;
    } catch (e) {
      return [];
    }
  }
}
