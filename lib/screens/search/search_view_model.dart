import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/search_api.dart';
import 'package:flutter_mini_project/models/search.dart';

class SearchViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final SearchAPI _recipeAPI = SearchAPI();
  List<Search> recipeList = [];

  int page = 0;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void searchRecipeList(String key) async {
    changeState(DataState.loading);

    try {
      recipeList = await _recipeAPI.searchRecipeByKey(key);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
