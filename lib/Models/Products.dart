class Products {
  bool status;
  String message;
  List<Data> data;

  Products({this.status, this.message, this.data});

  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  int departmentId;
  int categoryId;
  int subCategoryId;
  int childSubcategoryId;
  int manufacturerId;
  String name;
  String image;
  String variations;
  String productDesc;
  String shortDesc;
  String type;
  String ageGroup;
  String fabric;
  String sole;
  int specialPrice;
  int mrp;
  String sku;
  String size;
  String status;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.departmentId,
        this.categoryId,
        this.subCategoryId,
        this.childSubcategoryId,
        this.manufacturerId,
        this.name,
        this.image,
        this.variations,
        this.productDesc,
        this.shortDesc,
        this.type,
        this.ageGroup,
        this.fabric,
        this.sole,
        this.specialPrice,
        this.mrp,
        this.sku,
        this.size,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    childSubcategoryId = json['child_subcategory_id'] ?? 0;
    manufacturerId = json['manufacturer_id'];
    name = json['name'] ?? "";
    image = json['image'] ?? "";
    variations = json['variations'];
    productDesc = json['product_desc'];
    shortDesc = json['short_desc'];
    type = json['type'];
    ageGroup = json['age_group'];
    fabric = json['fabric'];
    sole = json['sole'];
    specialPrice = json['special_price'];
    mrp = json['mrp'] ?? 0;
    sku = json['sku'];
    size = json['size'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'] ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_id'] = this.departmentId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['child_subcategory_id'] = this.childSubcategoryId;
    data['manufacturer_id'] = this.manufacturerId;
    data['name'] = this.name ?? "";
    data['image'] = this.image ?? "";
    data['variations'] = this.variations;
    data['product_desc'] = this.productDesc;
    data['short_desc'] = this.shortDesc;
    data['type'] = this.type;
    data['age_group'] = this.ageGroup;
    data['fabric'] = this.fabric;
    data['sole'] = this.sole;
    data['special_price'] = this.specialPrice;
    data['mrp'] = this.mrp;
    data['sku'] = this.sku;
    data['size'] = this.size;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

