import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/article_api.dart';
import 'package:flutter_mini_project/models/article.dart';

class ArticleViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final ArticleAPI _articleAPI = ArticleAPI();
  List<Article> articleList = [];

  String getTags = '';

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getArticleList(String articleKey) async {
    changeState(DataState.loading);

    try {
      articleList = await _articleAPI.getArticle(articleKey);
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
