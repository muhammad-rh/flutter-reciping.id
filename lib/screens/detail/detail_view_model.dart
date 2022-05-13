import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/detail_api.dart';
import 'package:flutter_mini_project/models/detail.dart';

class DetailViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final DetailAPI _detailAPI = DetailAPI();
  Detail? detailList;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getDetailList(String keyTerm) async {
    changeState(DataState.loading);

    try {
      detailList = await _detailAPI.getDetailByKey(keyTerm);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }

  bool _isSaved = false;

  bool get isSaved => _isSaved;

  set isSaved(bool newValue) {
    _isSaved = newValue;
    notifyListeners();
  }

  get bookmark => _isSaved ? Icons.bookmark : Icons.bookmark_border_outlined;
}
