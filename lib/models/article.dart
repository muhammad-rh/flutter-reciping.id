class ResponseResultArticle {
  String? method;
  bool? status;
  List<dynamic>? results;

  ResponseResultArticle.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    results = json['results'];
  }
}

class Article {
  String? title;
  String? thumb;
  String? tags;
  String? key;

  Article({
    this.title,
    this.thumb,
    this.tags,
    this.key,
  });

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    tags = json['tags'];
    key = json['key'];
  }
}
