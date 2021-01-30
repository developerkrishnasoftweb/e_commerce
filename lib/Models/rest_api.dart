import 'dart:convert';

import 'package:e_commerce/Models/Categories.dart';
import 'package:http/http.dart' as http;

class URLS {
  static const String SERVER_URL = 'https://palshopie.com';
  static const String BASE_URL = '${URLS.SERVER_URL}/rest/default/V1/';
  static const String IMAGE_URL = SERVER_URL;
  static const String GET_CATEGORIES = '${URLS.BASE_URL}mma/categories';
}

class ApiService {
  static Future<Categories> getHomeCategories() async {
    final response = await http.get(URLS.GET_CATEGORIES);
    if (response.statusCode == 200) {
      print(response.body);
      return Categories.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
