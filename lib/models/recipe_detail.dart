class ResponseResultRecipeDetail {
  String? method;
  bool? status;
  RecipeDetail? results;

  ResponseResultRecipeDetail.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    status = json['status'];
    results =
        json['results'] != null ? RecipeDetail.fromJson(json['results']) : null;
  }
}

class RecipeDetail {
  String? title;
  String? thumb;
  String? servings;
  String? times;
  String? dificulty;
  Author? author;
  String? desc;
  List<NeedItem>? needItem;
  List<String>? ingredient;
  List<String>? step;
  bool? isFav;
  String? id;

  RecipeDetail({
    this.title,
    this.thumb,
    this.servings,
    this.times,
    this.dificulty,
    this.author,
    this.desc,
    this.needItem,
    this.ingredient,
    this.step,
    this.isFav,
    this.id,
  });

  RecipeDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    servings = json['servings'];
    times = json['times'];
    dificulty = json['dificulty'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    desc = json['desc'];
    if (json['needItem'] != null) {
      needItem = <NeedItem>[];
      json['needItem'].forEach((v) {
        needItem!.add(NeedItem.fromJson(v));
      });
    }
    ingredient = json['ingredient'].cast<String>();
    step = json['step'].cast<String>();
    isFav = json['isFav'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumb'] = thumb;
    data['servings'] = servings;
    data['times'] = times;
    data['dificulty'] = dificulty;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['desc'] = desc;
    if (needItem != null) {
      data['needItem'] = needItem!.map((v) => v.toJson()).toList();
    }
    data['ingredient'] = ingredient;
    data['step'] = step;
    data['isFav'] = isFav;
    data['id'] = id;
    return data;
  }
}

class Author {
  String? user;
  String? datePublished;

  Author({this.user, this.datePublished});

  Author.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    datePublished = json['datePublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['datePublished'] = datePublished;
    return data;
  }
}

class NeedItem {
  String? itemName;
  String? thumbItem;

  NeedItem({this.itemName, this.thumbItem});

  NeedItem.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    thumbItem = json['thumb_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['thumb_item'] = thumbItem;
    return data;
  }
}
