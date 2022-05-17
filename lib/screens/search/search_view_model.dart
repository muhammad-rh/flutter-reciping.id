import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/recipe_detail_api.dart';
import 'package:flutter_mini_project/models/api/search_api.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';
import 'package:flutter_mini_project/models/search.dart';

class SearchViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final SearchAPI _recipeAPI = SearchAPI();
  List<Search> recipeList = [];

  final RecipeDetailAPI _detailAPI = RecipeDetailAPI();
  RecipeDetail? detailList;

  int page = 0;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void searchRecipeList(String key) async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.searchRecipeByKey(key);

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
