class ProductSku {
  String sku;
  int position;
  String categoryId;

  ProductSku({this.sku, this.position, this.categoryId});

  ProductSku.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['position'] = this.position;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class ProductInfo {
  int id;
  String sku;
  String name;
  int attributeSetId;
  int price;
  int status;
  int visibility;
  String typeId;
  String createdAt;
  String updatedAt;
  int weight;

  ProductInfo(
      {this.id,
      this.sku,
      this.name,
      this.attributeSetId,
      this.price,
      this.status,
      this.visibility,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.weight});
  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
  }
}
