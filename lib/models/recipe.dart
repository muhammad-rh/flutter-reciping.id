class ResponseResultRecipe {
  String? method;
  bool? status;
  List<dynamic>? results;

  ResponseResultRecipe.fromJson(Map<String, dynamic> json)
      : method = json['method'],
        status = json['status'],
        results = json['results'];
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
