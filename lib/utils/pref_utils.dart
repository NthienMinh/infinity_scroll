import 'dart:convert';

import 'package:infinity_scroll/models/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils{

  String favorites = "favorite_products";

  Future<void> saveFavorites(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = products.map((p) => p.toJson()).toList();
    final encoded = jsonEncode(jsonList);
    await prefs.setString(favorites, encoded);
  }

  Future<List<Product>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(favorites);
    if (encoded == null) return [];
    final List decoded = jsonDecode(encoded);
    return decoded.map((e) => Product.fromJson(e)).toList();
  }

}