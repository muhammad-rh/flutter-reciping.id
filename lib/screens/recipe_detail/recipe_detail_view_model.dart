import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/recipe_detail_api.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';

class RecipeDetailViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final RecipeDetailAPI _detailAPI = RecipeDetailAPI();
  RecipeDetail? detailList;

  List<RecipeDetail> recipeList = [];

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getRecipeDetailList(String keyTerm) async {
    changeState(DataState.loading);

    try {
      detailList = await _detailAPI.getDetailByKey(keyTerm);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
