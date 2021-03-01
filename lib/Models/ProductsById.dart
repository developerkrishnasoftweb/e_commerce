import 'package:e_commerce/Models/MainCategory.dart';

class ProductsById {
  bool status;
  String message;
  List<Products> data;

  ProductsById({this.status, this.message, this.data});

  ProductsById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Products>();
      json['data'].forEach((v) {
        data.add(new Products.fromJson(v));
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