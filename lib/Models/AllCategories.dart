import 'MainCategory.dart';

class AllCategory {
  bool status;
  String message;
  List<MainData> data;

  AllCategory({this.status, this.message, this.data});

  AllCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<MainData>();
      json['data'].forEach((v) {
        data.add(new MainData.fromJson(v));
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

class MainData {
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
  List<SubCategotyLIst> subCategories;

  MainData(
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

  MainData.fromJson(Map<String, dynamic> json) {
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
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategotyLIst>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategotyLIst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image ?? '';
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategotyLIst {
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
  List<ChildSubCategory> childSubCategory;
  bool isSelected;

  SubCategotyLIst(
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
      this.childSubCategory,
      this.isSelected: false});

  SubCategotyLIst.fromJson(Map<String, dynamic> json) {
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
    if (json['child_sub_category'] != null) {
      childSubCategory = new List<ChildSubCategory>();
      json['child_sub_category'].forEach((v) {
        childSubCategory.add(new ChildSubCategory.fromJson(v));
      });
    }
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
    if (this.childSubCategory != null) {
      data['child_sub_category'] = this.childSubCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildSubCategory {
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
  List<Products> products;
  bool isSelected;

  ChildSubCategory(
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
      this.products,
      this.isSelected: false});

  ChildSubCategory.fromJson(Map<String, dynamic> json) {
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
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
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
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
