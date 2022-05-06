import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/recipe_api.dart';
import 'package:flutter_mini_project/models/recipe.dart';

class HomeViewModel extends ChangeNotifier {
  final RecipeAPI _recipeAPI = RecipeAPI();

  DataState dataState = DataState.loading;
  List<Recipe> recipeList = [];

  int page = 0;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getRecipeList() async {
    changeState(DataState.loading);

    try {
      recipeList = (await _recipeAPI.getRecipeByPage(page));
      changeState(DataState.filled);
      print('recipeList: $recipeList');
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }
}
