import 'package:flutter_mini_project/models/article.dart';
import 'package:flutter_mini_project/models/article_detail.dart';
import 'package:flutter_mini_project/utils/api.dart';

class ArticleAPI {
  final API _api = API();

  Future<List<Article>> getArticle(String key) async {
    try {
      var response = await _api.dio.get('/category/article/$key');

      ResponseResultArticle responseResult =
          ResponseResultArticle.fromJson(response.data);

      List<Article> articleList =
          responseResult.results!.map((e) => Article.fromJson(e)).toList();

      return articleList;
    } catch (e) {
      return [];
    }
  }

  Future<ArticleDetail?> getDetailArticle(String tags, String key) async {
    try {
      var response = await _api.dio.get('/article/$tags/$key');

      ResponseResultArticleDetail responseResult =
          ResponseResultArticleDetail.fromJson(response.data);

      return responseResult.results;
    } catch (e) {
      return ArticleDetail();
    }
  }
}
