class ResponseResultSearch {
  String? method;
  bool? status;
  List<dynamic>? results;

  ResponseResultSearch.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    results = json['results'];
  }
}

class Search {
  String? title;
  String? thumb;
  String? key;
  String? times;
  String? serving;
  String? difficulty;

  Search({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.serving,
    this.difficulty,
  });

  Search.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    key = json['key'];
    times = json['times'];
    serving = json['serving'];
    difficulty = json['difficulty'];
  }
}
