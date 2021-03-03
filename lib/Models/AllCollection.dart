class AllCollection {
  bool status;
  String message;
  List<AllCollectionData> data;

  AllCollection({this.status, this.message, this.data});

  AllCollection.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<AllCollectionData>();
      json['data'].forEach((v) {
        data.add(new AllCollectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCollectionData {
  int id;
  String title;
  String backgroundColor;
  String titleImage;
  Null position;
  String status;
  List<Collections> collections;

  AllCollectionData(
      {this.id,
        this.title,
        this.backgroundColor,
        this.titleImage,
        this.position,
        this.status,
        this.collections});

  AllCollectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    backgroundColor = json['background_color'];
    titleImage = json['title_image'];
    position = json['position'];
    status = json['status'];
    if (json['collections'] != null) {
      collections = new List<Collections>();
      json['collections'].forEach((v) {
        collections.add(new Collections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['background_color'] = this.backgroundColor;
    data['title_image'] = this.titleImage;
    data['position'] = this.position;
    data['status'] = this.status;
    if (this.collections != null) {
      data['collections'] = this.collections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collections {
  int id;
  int categoryId;
  String title;
  String offerString;
  String image;

  Collections(
      {this.id, this.categoryId, this.title, this.offerString, this.image});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    offerString = json['offer_string'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['offer_string'] = this.offerString;
    data['image'] = this.image;
    return data;
  }
}