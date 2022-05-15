import 'package:flutter_mini_project/models/recipe_detail.dart';
import 'package:flutter_mini_project/utils/api.dart';

class RecipeDetailAPI {
  final API _api = API();

  Future<RecipeDetail?> getDetailByKey(String key) async {
    try {
      var response = await _api.dio.get('/recipe/$key/');

      ResponseResultRecipeDetail responseResult =
          ResponseResultRecipeDetail.fromJson(response.data);

      return responseResult.results;
    } catch (e) {
      return RecipeDetail();
    }
  }
}
