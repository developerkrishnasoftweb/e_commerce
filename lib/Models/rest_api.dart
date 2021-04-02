import 'dart:convert';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/Banners.dart';
import 'package:e_commerce/Models/BestOffer.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:http/http.dart' as http;

import 'AllCollection.dart';
import 'countries_model.dart';

class URLS {
  // const String SERVER_URL = 'http://ecommerce.krishnasoftweb.com/';
// static const String SERVER_URL = 'https://palshopie.com';

  static const String SERVER_URL = 'https://ecommerce.krishnasoftweb.com';
  static const String GET_BANNERS = '${URLS.SERVER_URL}/api/banner';

  static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';

  // static const String BASE_URL = '${URLS.SERVER_URL}api/';
  static const String IMAGE_URL = SERVER_URL;
  static const String PAL_IMAGE_URL = 'https://palshopie.com';
  static const String GET_CATEGORIES = '${URLS.SERVER_URL}/api/category';
  static const String GET_TOP_CATEGORIES =
      '${URLS.SERVER_URL}/api/top-category';
  static const String GET_SUBCATEGORIES =
      '${URLS.SERVER_URL}/api/category?category_id=';
  static const String GET_GROCERIES =
      '${URLS.SERVER_URL}/api/category?category_type=Grocery';
  static const String GET_KIDS_FASHION =
      '${URLS.SERVER_URL}/api/category?category_type=Kids Fashion';
  static const String GET_TOP_PRODUCTS = '${URLS.SERVER_URL}/api/top-product';
  static const String GET_PRODUCTS =
      '${URLS.SERVER_URL}/api/product?category_id=';
  static const String GET_PRODUCT_QUANTITY =
      '${URLS.SERVER_URL}/api/product/get-quantity?product_id=';
  static const String GET_BEST_OFFERS = '${URLS.SERVER_URL}/api/best-offer';
  static const String GET_OFFERS1 = '${URLS.SERVER_URL}/api/home-section';
  static const String GET_FILTERS_DATA =
      '${URLS.SERVER_URL}/api/category/filter?category_id=';
  static const String GET_FILTER_PRODUCTS = '${URLS.SERVER_URL}/api/product';

  static const String DEPARTMENTS = '${URLS.BASE_URL}department';
  static const String CATEGORIES = '${URLS.BASE_URL}category';
  static const String PRODUCTS = '${URLS.BASE_URL}product';
  static const String GET_CATEGORIES_PRODUCTS = '${URLS.BASE_URL}categories';
  static const String GET_PRODUCT_LIST = '${URLS.BASE_URL}mma/categories';

  static const String PAL_SHOPPIE_BASE_URL =
      'https://www.palshopie.com/rest/V1/';
  static const String REGISTER = '${URLS.PAL_SHOPPIE_BASE_URL}customers/';
  static const String GENERATE_TOKEN =
      '${URLS.PAL_SHOPPIE_BASE_URL}integration/customer/token';
  static const String LOGIN = '${URLS.PAL_SHOPPIE_BASE_URL}customers/me';
  static const String CART_ID = '${URLS.PAL_SHOPPIE_BASE_URL}carts/mine';
  static const String ADD_TO_CART =
      'https://palshopie.com/rest/default/V1/carts/mine/items';
  static const String CART = '${URLS.PAL_SHOPPIE_BASE_URL}carts/mine/items';
  static const String UPDATE_CART_QUANTITY =
      '${PAL_SHOPPIE_BASE_URL}carts/mine/items/';
  static const String REMOVE_CART_ITEM =
      '${PAL_SHOPPIE_BASE_URL}carts/mine/items/';
  static const String ADD_ADDRESS = '${PAL_SHOPPIE_BASE_URL}customers/me';
  static const String UPDATE_ADDRESS = '${PAL_SHOPPIE_BASE_URL}customers/me';
  static const String DELETE_ADDRESS = '${PAL_SHOPPIE_BASE_URL}addresses/';
  static const String GET_COUNTRIES =
      '${PAL_SHOPPIE_BASE_URL}directory/countries';
  static const String SKU_WISE_PRODUCT =
      'http://ecommerce.krishnasoftweb.com/api/product?product_id=';
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

  static Future<ProductsById> getFilterProducts(
      Map<String, dynamic> bodyData) async {
    final response = await http.post(URLS.GET_FILTER_PRODUCTS,
        headers: {"Content-Type": "application/json"},
        body: json.encode(bodyData));
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
      final jsonResponse = await json.decode(response.body);
      if (jsonResponse['status']) {
        return jsonResponse['data'][0]['quantity'];
      } else {
        return null;
      }
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
    print("URL" + URLS.GET_FILTERS_DATA + id);
    final response = await http.get(URLS.GET_FILTERS_DATA + id);

    if (response.statusCode == 200) {
      return ResponseData(
          status: true, message: "", data: await jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<ResponseData> register(Map<String, dynamic> body) async {
    final response = await http.post(URLS.REGISTER,
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
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
  }

  static Future<ResponseData> generateToken(Map<String, dynamic> body,
      {bool getOnlyToken: false}) async {
    final response = await http.post(URLS.GENERATE_TOKEN,
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      if (getOnlyToken) {
        return ResponseData(
            token: response.body.replaceAll('"', ""),
            status: true,
            message: "Token fetched successfully");
      }
      return await login(response.body.replaceAll('"', ""));
    } else {
      print(response.body);
      return ResponseData(
          status: false,
          message: await jsonDecode(response.body)['message'],
          data: null);
    }
  }

  static Future<ResponseData> login(String token) async {
    final response = await http.get(URLS.LOGIN, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return ResponseData(
          status: true,
          message: "Logged in successfully",
          data: await jsonDecode(response.body),
          token: token);
    } else {
      return ResponseData(
          status: false,
          message: await jsonDecode(response.body)['message'],
          data: null);
    }
  }

  static Future<ResponseData> cartId(String token) async {
    try {
      final response = await http.post(URLS.CART_ID, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Cart id generated successfully",
            data: response.body,
            token: token);
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

  static Future<ResponseData> addToCart(
      Map<String, dynamic> body, String token) async {
    try {
      final response = await http.post(URLS.ADD_TO_CART,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Added to cart successfully",
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

  static Future<ResponseData> skuWiseProduct(String sku) async {
    try {
      final response = await http.get(URLS.SKU_WISE_PRODUCT + sku);
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Item details fetched successfully",
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

  static Future<ResponseData> cart(String token) async {
    try {
      final response = await http.get(URLS.CART, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Cart items are listed successfully",
            data: await jsonDecode(response.body),
            token: token);
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

  static Future<ResponseData> updateCartItemQuantity(
      {String token, String itemId, String qty, quoteId}) async {
    try {
      final response = await http.put(URLS.UPDATE_CART_QUANTITY + itemId,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "cartItem": {"item_id": itemId, "qty": qty, "quote_id": quoteId}
          }));
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Cart updated successfully",
            data: await jsonDecode(response.body),
            token: token);
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

  static Future<ResponseData> removeItemFromCart(
      {String token, String itemId}) async {
    try {
      final response = await http.delete(URLS.REMOVE_CART_ITEM + itemId,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Cart item deleted successfully",
            data: await jsonDecode(response.body),
            token: token);
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

  static Future<ResponseData> addAddress(
      {String token, Map<String, dynamic> body}) async {
    try {
      final response = await http.put(URLS.ADD_ADDRESS,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Address added successfully",
            data: await jsonDecode(response.body),
            token: token);
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

  static Future<ResponseData> updateAddress(
      {String token, Map<String, dynamic> body}) async {
    try {
      final response = await http.put(URLS.UPDATE_ADDRESS,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Address updated successfully",
            data: await jsonDecode(response.body),
            token: token);
      } else {
        print(response.body);
        return ResponseData(
            status: false,
            message: await jsonDecode(response.body)['message'],
            data: null);
      }
    } catch (_) {
      throw (_);
    }
  }

  static Future<ResponseData> removeAddress(
      {String addressId, String token}) async {
    try {
      final response = await http.delete(URLS.DELETE_ADDRESS + "$addressId",
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        return ResponseData(
            status: true,
            message: "Address deleted successfully",
            data: await jsonDecode(response.body),
            token: token);
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

  static Future<List<Countries>> getCountries() async {
    try {
      final response = await http.get(URLS.GET_COUNTRIES);
      List<Countries> countries = [];
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        jsonResponse.forEach((country) {
          countries.add(Countries.fromJson(country));
        });
        return countries;
      } else {
        return countries;
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
  final String token;

  ResponseData({this.status, this.message, this.data, this.token});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
        data: json['data'], message: json['message'], status: json['status']);
  }
}
