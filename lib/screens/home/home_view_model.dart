import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/categorys_api.dart';
import 'package:flutter_mini_project/models/api/recipe_api.dart';
import 'package:flutter_mini_project/models/api/recipe_detail_api.dart';
import 'package:flutter_mini_project/models/category.dart';
import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';

class HomeViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final RecipeAPI _recipeAPI = RecipeAPI();
  List<Recipe> recipeList = [];

  final RecipeDetailAPI _detailAPI = RecipeDetailAPI();
  RecipeDetail? detailList;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getRecipeList() async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.getRecipeByPage(0);

      for (int i = 0; i < recipeList.length; i++) {
        if (recipeList[i].title == null) {
          try {
            detailList = await _detailAPI.getDetailByKey(recipeList[i].key!);
            changeState(DataState.filled);
          } catch (e) {
            changeState(DataState.error);
          }

          recipeList[i].title = detailList?.title;
        }
      }
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
