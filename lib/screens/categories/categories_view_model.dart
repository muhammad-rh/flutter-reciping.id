import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/categorys_api.dart';
import 'package:flutter_mini_project/models/api/recipe_detail_api.dart';
import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';

class CategoriesViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final CategorysAPI _recipeAPI = CategorysAPI();
  List<Recipe> recipeList = [];

  final RecipeDetailAPI _detailAPI = RecipeDetailAPI();
  RecipeDetail? detailList;

  int page = 0;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getCategoryList(String key) async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.getCategoryList(key, page);
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
}
