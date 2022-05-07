import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/detail_api.dart';
import 'package:flutter_mini_project/models/detail.dart';

class DetailViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final DetailAPI _detailAPI = DetailAPI();
  List<Detail> detailList = [];

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getDetailList(String keyTerm) async {
    changeState(DataState.loading);

    try {
      detailList = await _detailAPI.getDetailByKey(keyTerm);
      changeState(DataState.filled);
      print('detail: $detailList');
    } catch (e) {
      print('error2: $e');
      changeState(DataState.error);
    }
  }

  // void getRecipeList() async {
  //   changeState(DataState.loading);

  //   try {
  //     recipeList = (await _recipeAPI.getRecipeByPage(page));
  //     changeState(DataState.filled);
  //     print('recipeList: $recipeList');
  //   } catch (e) {
  //     print('error2: $e');
  //     changeState(DataState.error);
  //   }
  // }
}
