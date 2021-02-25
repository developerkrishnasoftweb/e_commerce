import 'dart:convert';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/Banners.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/Products.dart';
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
  static const String GET_SUBCATEGORIES = '${URLS.SERVER_URL}/api/category?category_id=';

  static const String DEPARTMENTS = '${URLS.BASE_URL}department';
  static const String CATEGORIES = '${URLS.BASE_URL}category';
  static const String PRODUCTS = '${URLS.BASE_URL}product';
  static const String GET_CATEGORIES_PRODUCTS = '${URLS.BASE_URL}categories';
  static const String GET_PRODUCT_LIST = '${URLS.BASE_URL}mma/categories';
}

class ApiService {
  static Future<MainCategory> getHomeCategories() async {
    final response = await http.get(URLS.GET_CATEGORIES);
    if (response.statusCode == 200) {
      return MainCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<SubCategory> getSubCategories(int i) async {
    final response = await http.get(URLS.GET_SUBCATEGORIES + i.toString());
    print("res " + response.body.toString());
    if (response.statusCode == 200) {
      return SubCategory.fromJson(json.decode(response.body));
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

  static Future<Products> getProducts(String manufacturerId, String subCategoryId) async {
    Map<String, String> queryParams = {'manufacturer_id': manufacturerId, 'sub_category_id': subCategoryId};
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(URLS.PRODUCTS + '?' + queryString);
    if (response.statusCode == 200) {
      return Products.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

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
}
