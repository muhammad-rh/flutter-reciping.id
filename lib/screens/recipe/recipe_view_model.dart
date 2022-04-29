import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/models/api/recipe_api.dart';
import 'package:flutter_mini_project/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeViewModel extends ChangeNotifier {
  List<RecipeModel> recipes = [];
  final RecipeAPI _recipeAPI = RecipeAPI();

  RecipeViewModel() {
    initialState();
  }

  void initialState() async {
    final r = await _recipeAPI.getRecipes();
    recipes = r;
    syncDataWithProvider();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('recipes');

    if (result != null) {
      recipes = result.map((e) => RecipeModel.fromJson(jsonDecode(e))).toList();
    }
    notifyListeners();
  }
}
