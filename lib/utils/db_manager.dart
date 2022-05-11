import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/helper/db_helper.dart';
import 'package:flutter_mini_project/models/create_recipe.dart';

class DbManager extends ChangeNotifier {
  DataState dataState = DataState.loading;

  List<CreateRecipe> _recipeList = [];
  late DatabaseHelper _dbHelper;

  List<CreateRecipe> get recipeList => _recipeList;

  DbManager() {
    _dbHelper = DatabaseHelper();
    _getAllRecipes();
  }

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void _getAllRecipes() async {
    changeState(DataState.loading);

    try {
      _recipeList = await _dbHelper.getAllRecipe();
      print('recipeList: $_recipeList');
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }

  Future<void> addRecipe(CreateRecipe recipe) async {
    changeState(DataState.loading);

    try {
      await _dbHelper.addRecipe(recipe);
      _getAllRecipes();
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }

  Future<CreateRecipe> getRecipeByid(int id) async {
    return await _dbHelper.getRecipeById(id);
  }

  void updateRecipe(CreateRecipe recipe) async {
    changeState(DataState.loading);

    try {
      await _dbHelper.updateRecipe(recipe);
      _getAllRecipes();
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }

  void deleteRecipe(int id) async {
    changeState(DataState.loading);

    try {
      await _dbHelper.deleteRecipe(id);
      _getAllRecipes();
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }
}
