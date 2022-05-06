class ResponseResultCategorys {
  String? method;
  bool? status;
  List<dynamic>? results;

  ResponseResultCategorys.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    results = json['results'];
  }
}

class Categorys {
  String? category;
  String? url;
  String? key;

  Categorys({
    this.category,
    this.url,
    this.key,
  });

  Categorys.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    url = json['url'];
    key = json['key'];
  }
}
