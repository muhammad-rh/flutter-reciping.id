import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/article_api.dart';
import 'package:flutter_mini_project/models/article_detail.dart';

class ArticleDetailViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final ArticleAPI _detailAPI = ArticleAPI();
  ArticleDetail? detailList;

  String getTags = '';

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getArticleDetailList(String tags, String key) async {
    changeState(DataState.loading);

    if (tags == 'Inspirasi Dapur') {
      getTags = 'inspirasi-dapur';
    } else if (tags == 'Makanan & Gaya Hidup') {
      getTags = 'makanan-gaya-hidup';
    } else if (tags == 'Tips Masak') {
      getTags = 'tips-masak';
    }

    try {
      detailList = await _detailAPI.getDetailArticle(getTags, key);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
