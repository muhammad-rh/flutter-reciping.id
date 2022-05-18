import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/categorys_api.dart';
import 'package:flutter_mini_project/models/api/recipe_api.dart';
import 'package:flutter_mini_project/models/api/recipe_detail_api.dart';
import 'package:flutter_mini_project/models/api/search_api.dart';
import 'package:flutter_mini_project/models/category.dart';
import 'package:flutter_mini_project/models/recipe.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';
import 'package:flutter_mini_project/models/search.dart';

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

  final CategorysAPI _categoryAPI = CategorysAPI();
  List<Category> categoryList = [];

  void getCategoryList() async {
    changeState(DataState.loading);

    try {
      categoryList = await _categoryAPI.getCategorys();
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }

  List<Search> searchList = [];
  final SearchAPI _searchAPI = SearchAPI();

  void searchRecipeList(String key) async {
    changeState(DataState.loading);

    try {
      searchList = await _searchAPI.searchRecipeByKey(key);

      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].title == null) {
          try {
            detailList = await _detailAPI.getDetailByKey(searchList[i].key!);
            changeState(DataState.filled);
          } catch (e) {
            changeState(DataState.error);
          }

          searchList[i].title = detailList?.title;
        }
      }
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }

  final CategorysAPI _categoriesListAPI = CategorysAPI();
  List<Recipe> categoriesList = [];

  int page = 0;

  void getCategoriesList(String key) async {
    changeState(DataState.loading);

    try {
      categoriesList = await _categoriesListAPI.getCategoryList(key, page);
      for (int i = 0; i < categoriesList.length; i++) {
        if (categoriesList[i].title == null) {
          try {
            detailList =
                await _detailAPI.getDetailByKey(categoriesList[i].key!);
            changeState(DataState.filled);
          } catch (e) {
            changeState(DataState.error);
          }

          categoriesList[i].title = detailList?.title;
        }
      }
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
