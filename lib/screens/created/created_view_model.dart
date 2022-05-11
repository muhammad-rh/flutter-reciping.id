// import 'package:flutter/material.dart';
// import 'package:flutter_mini_project/constans/state.dart';
// import 'package:flutter_mini_project/models/create_recipe.dart';
// import 'package:flutter_mini_project/helper/db_helper.dart';

// class BookmarkViewModel extends ChangeNotifier {
//   DataState dataState = DataState.loading;

//   DbHelper db = DbHelper();
//   List<CreateRecipe> recipeList = [];

//   void changeState(DataState state) {
//     dataState = state;
//     notifyListeners();
//   }

//   Future<void> _getAllRecipe() async {
//     changeState(DataState.loading);

//     try {
//       var list = await db.getAllRecipe();
//       // setState
//       changeState(DataState.filled);
//     } catch (e) {
//       print('error1: $e');
//       changeState(DataState.error);
//     }
//   }
// }
