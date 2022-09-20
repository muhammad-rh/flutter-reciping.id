import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/recipe_detail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  List<RecipeDetail> recipeList = [];

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void isFavourited(RecipeDetail _recipe) {
    // print('isFavourite');
    final int index =
        recipeList.indexWhere((element) => element.id == _recipe.id);
    if (index == -1) {
      addFavourite(_recipe);
    } else if (index != -1) {
      deleteFavourite(index);
    }
  }

  void addFavourite(RecipeDetail _recipe) {
    if (_recipe.isFav == false || _recipe.isFav == null) {
      _recipe.isFav == true;
      recipeList.add(_recipe);
      updateSharedPreferences();
      Fluttertoast.showToast(msg: 'Added to Favourite');
    }

    notifyListeners();
  }

  void removeFavourite(RecipeDetail _recipe) {
    final int index =
        recipeList.indexWhere((element) => element.id == _recipe.id);
    if (index != -1) {
      recipeList.removeWhere((element) => element.id == _recipe.id);
    }
    updateSharedPreferences();
    Fluttertoast.showToast(msg: 'Deleted From Favourite');
    notifyListeners();
  }

  void deleteFavourite(int index) {
    recipeList.removeAt(index);
    updateSharedPreferences();
    Fluttertoast.showToast(msg: 'Deleted From Favourite');
    notifyListeners();
  }

  Future updateSharedPreferences() async {
    List<String> myRecipeList =
        recipeList.map((e) => json.encode(e.toJson())).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('recipeList', myRecipeList);
  }

  Future syncDataWithProvider() async {
    changeState(DataState.loading);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('recipeList');

    try {
      if (result != null) {
        recipeList =
            result.map((e) => RecipeDetail.fromJson(json.decode(e))).toList();
      }
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
