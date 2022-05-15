class ResponseResultArticleDetail {
  String? method;
  bool? status;
  ArticleDetail? results;

  ResponseResultArticleDetail.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    results = json['results'] != null
        ? ArticleDetail.fromJson(json['results'])
        : null;
  }
}

class ArticleDetail {
  String? title;
  String? thumb;
  String? author;
  String? datePublished;
  String? description;

  ArticleDetail({
    this.title,
    this.thumb,
    this.author,
    this.datePublished,
    this.description,
  });

  ArticleDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    author = json['author'];
    datePublished = json['date_published'];
    description = json['description'];
  }
}
