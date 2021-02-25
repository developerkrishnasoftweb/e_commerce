class MainCategory {
  bool status;
  String message;
  List<Categories> data;

  MainCategory({this.status, this.message, this.data});

  MainCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Categories>();
      json['data'].forEach((v) {
        data.add(new Categories.fromJson(v));
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

class Categories {
  int id;
  int parentId;
  String name;
  String image;
  int isActive;
  int position;
  int level;
  int productCount;
  String createdAt;
  String updatedAt;
  List<SubCategories> subCategories;

  Categories(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.createdAt,
        this.updatedAt,
        this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategories>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  int parentId;
  String name;
  String image;
  int isActive;
  int position;
  int level;
  int productCount;
  String createdAt;
  String updatedAt;
  bool isSelected;

  SubCategories(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.createdAt,
        this.updatedAt,
        this.isSelected: false});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'] ?? '';
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = this.isSelected ?? false;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}