import 'dart:convert';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/Banners.dart';
import 'package:e_commerce/Models/BestOffer.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:http/http.dart' as http;

import 'AllCollection.dart';

class URLS {
  // const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com/';
// static const String SERVER_URL = 'https://palshopie.com';

  static const String SERVER_URL = 'https://ecommerce.krishnasoftweb.com';
  static const String GET_BANNERS = '${URLS.SERVER_URL}/api/banner';

  static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';

  // static const String BASE_URL = '${URLS.SERVER_URL}api/';
  static const String IMAGE_URL = SERVER_URL;
  static const String PAL_IMAGE_URL = 'https://palshopie.com';
  static const String EMPTY_IMAGE_URL = 'https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png';
  static const String GET_CATEGORIES = '${URLS.SERVER_URL}/api/category';
  static const String GET_TOP_CATEGORIES = '${URLS.SERVER_URL}/api/top-category';
  static const String GET_SUBCATEGORIES = '${URLS.SERVER_URL}/api/category?category_id=';
  static const String GET_GROCERIES = '${URLS.SERVER_URL}/api/category?category_type=Grocery';
  static const String GET_KIDS_FASHION = '${URLS.SERVER_URL}/api/category?category_type=Kids Fashion';
  static const String GET_TOP_PRODUCTS = '${URLS.SERVER_URL}/api/top-product';
  static const String GET_PRODUCTS = '${URLS.SERVER_URL}/api/product?category_id=';
  static const String GET_PRODUCT_QUANTITY = '${URLS.SERVER_URL}/api/product/get-quantity?product_id=';
  static const String GET_BEST_OFFERS = '${URLS.SERVER_URL}/api/best-offer';
  static const String GET_OFFERS1 = '${URLS.SERVER_URL}/api/home-section';
  static const String GET_FILTERS_DATA = '${URLS.SERVER_URL}/api/category/filter?category_id=';
  static const String GET_FILTER_PRODUCTS = '${URLS.SERVER_URL}/api/product';

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

  static Future<BestOffers> getBestOfferCollection() async {
    final response = await http.get(URLS.GET_BEST_OFFERS);

    if (response.statusCode == 200) {
      return BestOffers.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<AllCollection> getOffers1() async {
    final response = await http.get(URLS.GET_OFFERS1);

    if (response.statusCode == 200) {
      return AllCollection.fromJson(json.decode(response.body));
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

  static Future<AllCategory> getGroceries() async {
    final response = await http.get(URLS.GET_GROCERIES);

    if (response.statusCode == 200) {
      return AllCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<AllCategory> getKidsFashion() async {
    final response = await http.get(URLS.GET_KIDS_FASHION);

    if (response.statusCode == 200) {
      return AllCategory.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<ProductsById> getProductsById(String id) async {
    final response = await http.get(URLS.GET_PRODUCTS + id);

    if (response.statusCode == 200) {
      return ProductsById.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<ProductsById> getFilterProducts(Map<String, dynamic> bodyData) async {
    final response = await http.post(URLS.GET_FILTER_PRODUCTS, headers: {"Content-Type": "application/json"}, body: json.encode(bodyData));
    print("Body" + bodyData.toString());

    if (response.statusCode == 200) {
      return ProductsById.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<int> getProductQuantity(String id) async {
    final response = await http.get(URLS.GET_PRODUCT_QUANTITY + id);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'][0]['quantity'];
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

  static Future<ProductsById> getTopProducts() async {
    final response = await http.get(URLS.GET_TOP_PRODUCTS);

    if (response.statusCode == 200) {
      return ProductsById.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<ResponseData> getFiltersData(String id) async {
    print("URL     " + URLS.GET_FILTERS_DATA + id);
    final response = await http.get(URLS.GET_FILTERS_DATA + id);

    if (response.statusCode == 200) {
      return ResponseData(status: true, message: "", data: await jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ResponseData> register(Map<String, dynamic> body) async {
    final response = await http.post(URLS.REGISTER, body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return ResponseData(status: true, message: "Registered successfully", data: await jsonDecode(response.body));
    } else {
      return ResponseData(status: false, message: await jsonDecode(response.body)['message'], data: null);
    }
  }

  static Future<ResponseData> generateToken(Map<String, dynamic> body) async {
    final response = await http.post(URLS.GENERATE_TOKEN, body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return await login(response.body.replaceAll('"', ""));
    } else {
      return ResponseData(status: false, message: await jsonDecode(response.body)['message'], data: null);
    }
  }

  static Future<ResponseData> login(String token) async {
    final response = await http.get(URLS.LOGIN, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return ResponseData(status: true, message: "Logged in successfully", data: await jsonDecode(response.body));
    } else {
      return ResponseData(status: false, message: await jsonDecode(response.body)['message'], data: null);
    }
  }
}

class ResponseData {
  final bool status;
  final String message;
  final dynamic data;

  ResponseData({this.status, this.message, this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(data: json['data'], message: json['message'], status: json['status']);
  }
}
