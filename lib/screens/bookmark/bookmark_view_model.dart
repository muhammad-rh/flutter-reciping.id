import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/recipe.dart';

class BookmarkViewModel extends ChangeNotifier {
  final _recipe = <Recipe>[];
  List<Recipe> get recipe => _recipe;

  void addBookmark(Recipe recipe) {
    _recipe.add(recipe);
    print('RecipeToBookmark: $_recipe');
    notifyListeners();
  }

  void deleteBookmark(int index, input) {
    _recipe[index] = input;
    _recipe.removeAt(index);
    print('RecipeToBookmark: $_recipe');
    notifyListeners();
  }
}
