import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/categorys_api.dart';
import 'package:flutter_mini_project/models/recipe.dart';

class CategoriesViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final CategorysAPI _recipeAPI = CategorysAPI();
  List<Recipe> recipeList = [];

  int page = 0;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getCategoryList(String key) async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.getCategoryList(key, page);
      changeState(DataState.filled);
      // print('recipeList: $recipeList');
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }
}
