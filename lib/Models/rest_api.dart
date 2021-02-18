import 'dart:convert';
import 'package:e_commerce/Models/Products.dart';
import 'package:http/http.dart' as http;
import 'Departments.dart';
import 'SubCategories.dart';

class URLS {
  static const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com/';
 // static const String SERVER_URL = 'https://palshopie.com';
 // static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';
  static const String BASE_URL = '${URLS.SERVER_URL}api/';
  static const String IMAGE_URL = SERVER_URL;
  static const String GET_CATEGORIES = '${URLS.BASE_URL}mma/categories';
  static const String DEPARTMENTS = '${URLS.BASE_URL}department';
  static const String CATEGORIES = '${URLS.BASE_URL}category';
  static const String PRODUCTS = '${URLS.BASE_URL}product';
  static const String GET_PRODUCT_LIST = '${URLS.BASE_URL}mma/categories';
}

class ApiService {

  static Future<Departments> getDepartments() async {
    final response = await http.get(URLS.DEPARTMENTS);
    if (response.statusCode == 200) {
      print(response.body);
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
      print(response.body);
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
      print("PRODUCTS RESPONSE " + response.body);
      return Products.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

}
