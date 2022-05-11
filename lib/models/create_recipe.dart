class CreateRecipe {
  String? title;
  String? thumb;
  String? servings;
  String? times;
  String? dificulty;
  String? datePublished;
  String? desc;
  List<String>? ingredient;
  List<String>? step;

  CreateRecipe({
    this.title,
    this.thumb,
    this.servings,
    this.times,
    this.dificulty,
    this.datePublished,
    this.desc,
    this.ingredient,
    this.step,
  });

  CreateRecipe.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    thumb = map['thumb'];
    servings = map['servings'];
    times = map['times'];
    dificulty = map['dificulty'];
    datePublished = map['datePublished'];
    desc = map['desc'];
    ingredient = map['ingredient'].cast<String>();
    step = map['step'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['thumb'] = thumb;
    map['servings'] = servings;
    map['times'] = times;
    map['dificulty'] = dificulty;
    map['author'] = datePublished;
    map['desc'] = desc;
    map['ingredient'] = ingredient;
    map['step'] = step;

    return map;
  }
}
