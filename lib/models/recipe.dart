class ResponseResult {
  String? method;
  bool? status;
  List<dynamic>? results;

  ResponseResult.fromJson(Map<String, dynamic> json)
      : method = json['method'],
        status = json['status'],
        results = json['results'];
  // if (json['results'] != null) {
  //   results = <dynamic>[];
  //   json['results'].forEach((v) {
  //     results!.add(Recipe.fromJson(v));
  //   });
  // }
  // }
}

class Recipe {
  String? title;
  String? thumb;
  String? key;
  String? times;
  String? portion;
  String? dificulty;

  Recipe({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
  });

  Recipe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    key = json['key'];
    times = json['times'];
    portion = json['portion'];
    dificulty = json['dificulty'];
  }
}
