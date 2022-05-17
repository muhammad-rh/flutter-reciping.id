import 'package:flutter/material.dart';
import 'package:flutter_mini_project/constans/state.dart';
import 'package:flutter_mini_project/models/api/article_api.dart';
import 'package:flutter_mini_project/models/article.dart';
import 'package:flutter_mini_project/models/article_detail.dart';

class ArticleViewModel extends ChangeNotifier {
  DataState dataState = DataState.loading;

  final ArticleAPI _articleAPI = ArticleAPI();
  List<Article> articleList = [];

  ArticleDetail? detailList;

  String getTags = '';

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getArticleList(String articleKey) async {
    changeState(DataState.loading);

    try {
      articleList = await _articleAPI.getArticle(articleKey);
      for (int i = 0; i < articleList.length; i++) {
        if (articleList[i].title == null) {
          if (articleList[i].tags == 'Inspirasi Dapur') {
            getTags = 'inspirasi-dapur';
          } else if (articleList[i].tags == 'Makanan & Gaya Hidup') {
            getTags = 'makanan-gaya-hidup';
          } else if (articleList[i].tags == 'Tips Masak') {
            getTags = 'tips-masak';
          }

          try {
            detailList = await _articleAPI.getDetailArticle(
              getTags,
              articleList[i].key!,
            );
            changeState(DataState.filled);
          } catch (e) {
            changeState(DataState.error);
          }

          articleList[i].title = detailList?.title;
          articleList[i].thumb = detailList?.thumb;
        }
      }
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
