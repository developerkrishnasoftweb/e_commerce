class Categories {
  int id;
  int parentId;
  String name;
  String image;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<ChildrenData> childrenData;

  Categories(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    image = json['image'] != null ? json['image'] : "";
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<ChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new ChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['image'] = this.image;
    data['product_count'] = this.productCount;
    if (this.childrenData != null){
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }else{
      childrenData = [];
    }
    return data;
  }
}

class ChildrenData {
  int id;
  int parentId;
  String name;
  String image;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<ChildrenData> childrenData;

  ChildrenData(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.position,
        this.level,
        this.image,
        this.productCount,
        this.childrenData});

  ChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    image = json['image'] != null ? json['image'] : "";
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<ChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new ChildrenData.fromJson(v));
      });
    }else{
      childrenData = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['image'] = this.image;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }else{
      childrenData = [];
    }
    return data;
  }
}