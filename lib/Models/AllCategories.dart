class AllCategories {
  int id;
  int parentId;
  String name;
  Null image;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<ChildrenData> childrenData;

  AllCategories(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  AllCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
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
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
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
        this.image,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  ChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
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
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
