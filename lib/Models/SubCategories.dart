class SubCategory {
  bool status;
  String message;
  Data data;

  SubCategory({this.status, this.message, this.data});

  SubCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int departmentId;
  String title;
  String image;
  String position;
  String status;
  String createdAt;
  String updatedAt;
  List<SubCategories> subCategories;

  Data(
      {this.id,
        this.departmentId,
        this.title,
        this.image,
        this.position,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    title = json['title'] ?? "";
    image = json['image'] ?? "";
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      subCategories = List<SubCategories>();
      json['sub_categories'].forEach((v) {
        subCategories.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['position'] = this.position;
    data['status'] = this.status;
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
  int categoryId;
  String title;
  String image;
  String position;
  String status;
  String createdAt;
  String updatedAt;
  List<Brands> brands;

  SubCategories(
      {this.id,
        this.categoryId,
        this.title,
        this.image,
        this.position,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.brands});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    image = json['image'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['brands'] != null) {
      brands = List<Brands>();
      json['brands'].forEach((v) {
        brands.add(Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.brands != null) {
      data['brands'] = this.brands.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int id;
  String title;
  String email;
  String mobile;
  String status;
  String createdAt;
  String updatedAt;

  Brands(
      {this.id,
        this.title,
        this.email,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



