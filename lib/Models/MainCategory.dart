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
  String banner_image;
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
        this.banner_image,
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
    banner_image = json['banner_image'] ?? '';
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
    data['banner_image'] = this.banner_image;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) {
            return v.toJson();
          }).toList();
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
  List<Products> products;
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
        this.products,
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

class Products {
  int id;
  String sku;
  String name;
  String attributeSetId;
  String categoryId;
  int price;
  int quantity;
  int maxQuantity;
  int discount;
  bool inCart;
  String status;
  String visibility;
  String typeId;
  String createdAt;
  String updatedAt;
  List<Images> images;
  List<Attributes> attributes;

  Products(
      {this.id,
        this.sku,
        this.name,
        this.attributeSetId,
        this.categoryId,
        this.price,
        this.status,
        this.visibility,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.images,
        this.quantity,
        this.maxQuantity,
        this.discount,
        this.inCart,
        this.attributes});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    categoryId = json['category_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = new List<Attributes>();
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    quantity = 1;
    maxQuantity = 10;
    discount = 5;
    inCart = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['attribute_set_id'] = this.attributeSetId;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  String productId;
  String mediaType;
  String label;
  int position;
  int disabled;
  String types;
  String file;
  String createdAt;
  String updatedAt;

  Images(
      {this.id,
        this.productId,
        this.mediaType,
        this.label,
        this.position,
        this.disabled,
        this.types,
        this.file,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['media_type'] = this.mediaType;
    data['label'] = this.label;
    data['position'] = this.position;
    data['disabled'] = this.disabled;
    data['types'] = this.types;
    data['file'] = this.file;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Attributes {
  int id;
  int productId;
  String title;
  String value;
  String createdAt;
  String updatedAt;

  Attributes(
      {this.id,
        this.productId,
        this.title,
        this.value,
        this.createdAt,
        this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}




