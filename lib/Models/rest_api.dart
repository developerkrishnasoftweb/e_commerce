import 'dart:convert';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/Banners.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/TopProducts.dart';
import 'package:e_commerce/Models/sku.dart';
import 'package:http/http.dart' as http;
import 'Departments.dart';
import 'SubCategory.dart';

class URLS {
  // const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com/';
// static const String SERVER_URL = 'https://palshopie.com';

  static const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com';
  static const String GET_BANNERS = '${URLS.SERVER_URL}/api/banner';

  static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';

  // static const String BASE_URL = '${URLS.SERVER_URL}api/';
  static const String IMAGE_URL = SERVER_URL;
  static const String PAL_IMAGE_URL = 'https://palshopie.com';
  static const String GET_CATEGORIES = '${URLS.SERVER_URL}/api/category';
  static const String GET_TOP_CATEGORIES = '${URLS.SERVER_URL}/api/top-category';
  static const String GET_SUBCATEGORIES = '${URLS.SERVER_URL}/api/category?category_id=';
  static const String GET_TOP_PRODUCTS = '${URLS.SERVER_URL}/api/top-product';

  static const String DEPARTMENTS = '${URLS.BASE_URL}department';
  static const String CATEGORIES = '${URLS.BASE_URL}category';
  static const String PRODUCTS = '${URLS.BASE_URL}product';
  static const String GET_CATEGORIES_PRODUCTS = '${URLS.BASE_URL}categories';
  static const String GET_PRODUCT_LIST = '${URLS.BASE_URL}mma/categories';

  static const String PAL_SHOPPIE_BASE_URL = 'https://www.palshopie.com/rest/V1/';
  static const String REGISTER = '${URLS.PAL_SHOPPIE_BASE_URL}customers/';
  static const String GENERATE_TOKEN = '${URLS.PAL_SHOPPIE_BASE_URL}integration/customer/token';
  static const String LOGIN = '${URLS.PAL_SHOPPIE_BASE_URL}customers/me';

}

class ApiService {

  static Future<AllCategory> getHomeCategories() async {
    final response = await http.get(URLS.GET_CATEGORIES);
    if (response.statusCode == 200) {
      return AllCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<MainCategory> getTopCategories() async {
    final response = await http.get(URLS.GET_TOP_CATEGORIES);
    if (response.statusCode == 200) {
      return MainCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }


  static Future<AllCategory> getSubCategories(String i) async {
    final response = await http.get(URLS.GET_SUBCATEGORIES + i.toString());
    print("res " + response.body.toString());
    if (response.statusCode == 200) {
      return AllCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<Banners> getBanners(String type) async {
    final response = await http.get(URLS.GET_BANNERS + '?banner_type=' + type);
    if (response.statusCode == 200) {
      return Banners.fromJson(json.decode(response.body));
    } else {
      print("res e" + response.toString());
      return null;
    }
  }

  static Future<Banners> getBannersTopCategory() async {
    return getBanners('top category');
  }

  static Future<Banners> getBannersTopDeals() async {
    return getBanners('top deals');
  }

  static Future<Banners> getBannersBestDeals() async {
    return getBanners('best deals');
  }

  static Future<Banners> getBannersExclusiveDeals() async {
    return getBanners('exclusive deals');
  }

  static Future<TopProducts> getTopProducts() async {
    final response = await http.get(URLS.GET_TOP_PRODUCTS);
    if (response.statusCode == 200) {
      return TopProducts.fromJson(json.decode(response.body));
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
    Map<String, String> queryParams = {'category_id': categoryId, 'department_id': departmentId};
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(URLS.CATEGORIES + '?' + queryString);
    if (response.statusCode == 200) {
      return SubCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  // static Future<Products> getProducts(String manufacturerId, String subCategoryId) async {
  //   Map<String, String> queryParams = {'manufacturer_id': manufacturerId, 'sub_category_id': subCategoryId};
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   final response = await http.get(URLS.PRODUCTS + '?' + queryString);
  //   if (response.statusCode == 200) {
  //     return Products.fromJson(json.decode(response.body));
  //   } else {
  //     return null;
  //   }
  // }

  static Future<List<ProductSku>> getProduct(String subCategoryId) async {
    try {
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
    } catch (e) {
      throw (e);
    }
  }

  static Future<ResponseData> register(Map<String, dynamic> body) async {
    try {
      final response = await http.post(URLS.REGISTER,
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Registered successfully",
            data: await jsonDecode(response.body));
      } else {
        return ResponseData(
            status: false,
            message: await jsonDecode(response.body)['message'],
            data: null);
      }
    } catch (_) {
      throw (_);
    }
  }

  static Future<ResponseData> generateToken(Map<String, dynamic> body) async {
    try {
      final response = await http.post(URLS.GENERATE_TOKEN,
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return await login(response.body.replaceAll('"', ""));
      } else {
        return ResponseData(
            status: false,
            message: await jsonDecode(response.body)['message'],
            data: null);
      }
    } catch (_) {
      throw (_);
    }
  }

  static Future<ResponseData> login(String token) async {
    try {
      final response = await http.get(URLS.LOGIN, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Logged in successfully",
            data: await jsonDecode(response.body));
      } else {
        return ResponseData(
            status: false,
            message: await jsonDecode(response.body)['message'],
            data: null);
      }
    } catch (_) {
      throw (_);
    }
  }








}



class ResponseData {
  final bool status;
  final String message;
  final dynamic data;

  ResponseData({this.status, this.message, this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
        data: json['data'], message: json['message'], status: json['status']);
  }

}
