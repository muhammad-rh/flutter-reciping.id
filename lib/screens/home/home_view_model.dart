import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/categorys_api.dart';
import 'package:flutter_mini_project/models/api/recipe_api.dart';
import 'package:flutter_mini_project/models/category.dart';
import 'package:flutter_mini_project/models/recipe.dart';

class HomeViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final RecipeAPI _recipeAPI = RecipeAPI();
  List<Recipe> recipeList = [];

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getRecipeList() async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.getRecipeByPage(0);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }

  final CategorysAPI _categorysAPI = CategorysAPI();
  List<Category> categoryList = [];

  void getCategoryList() async {
    changeState(DataState.loading);

    try {
      categoryList = await _categorysAPI.getCategorys();
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
