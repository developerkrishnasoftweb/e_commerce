class BestOffers {
  bool status;
  String message;
  List<BestoffersData> data;

  BestOffers({this.status, this.message, this.data});

  BestOffers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<BestoffersData>();
      json['data'].forEach((v) {
        data.add(new BestoffersData.fromJson(v));
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

class BestoffersData {
  int id;
  String title;
  String offerString;
  int categoryId;
  int subCategoryId;
  int childSubcategoryId;
  String image;
  String status;

  BestoffersData(
      {this.id,
        this.title,
        this.offerString,
        this.categoryId,
        this.subCategoryId,
        this.childSubcategoryId,
        this.image,
        this.status});

  BestoffersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    offerString = json['offer_string'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    childSubcategoryId = json['child_subcategory_id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['offer_string'] = this.offerString;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['child_subcategory_id'] = this.childSubcategoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}


