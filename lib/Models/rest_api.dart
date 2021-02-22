import 'dart:convert';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/Products.dart';
import 'package:e_commerce/Models/sku.dart';
import 'package:http/http.dart' as http;
import 'Departments.dart';
import 'SubCategories.dart';

class URLS {
  // const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com/';
 static const String SERVER_URL = 'https://palshopie.com';
 static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';
 // static const String BASE_URL = '${URLS.SERVER_URL}api/';
  static const String IMAGE_URL = SERVER_URL;
  static const String GET_CATEGORIES = '${URLS.BASE_URL}mma/categories';
  static const String DEPARTMENTS = '${URLS.BASE_URL}department';
  static const String CATEGORIES = '${URLS.BASE_URL}category';
  static const String PRODUCTS = '${URLS.BASE_URL}product';
  static const String GET_CATEGORIES_PRODUCTS = '${URLS.BASE_URL}categories';
  static const String GET_PRODUCT_LIST = '${URLS.BASE_URL}mma/categories';
}

class ApiService {

  static Future<AllCategories> getHomeCategories() async {
    final response = await http.get(URLS.GET_CATEGORIES);
    if (response.statusCode == 200) {
      return AllCategories.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<Departments> getDepartments() async {
    final response = await http.get(URLS.DEPARTMENTS);
    if (response.statusCode == 200) {
      return Departments.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<SubCategory> getCategories(String categoryId, String departmentId) async {
    Map<String, String> queryParams = {
      'category_id': categoryId,
      'department_id': departmentId
    };
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(URLS.CATEGORIES + '?' + queryString);
    if (response.statusCode == 200) {
      return SubCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<Products> getProducts(String manufacturerId, String subCategoryId) async {
    Map<String, String> queryParams = {
      'manufacturer_id': manufacturerId,
      'sub_category_id': subCategoryId
    };
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(URLS.PRODUCTS + '?' + queryString);
    if (response.statusCode == 200) {
      return Products.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<List<ProductSku>> getProduct(String subCategoryId) async {
    try{
      final response = await http.get(URLS.GET_CATEGORIES_PRODUCTS + "/" + subCategoryId + "/" + 'products');
      if (response.statusCode == 200) {
        List<ProductSku> sku = List();
        json.decode(response.body).forEach((v) {
          sku.add(ProductSku.fromJson(v));
        });
        return sku;
      } else {
        return null;
      }
    } catch(e) {
      throw(e);
    }
  }

}
