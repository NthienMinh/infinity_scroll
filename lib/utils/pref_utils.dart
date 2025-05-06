import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils{

  String favorites = "favorite_products";

  Future<void> saveFavorites(List<int> productsId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listId = productsId.map((e)=>e.toString()).toList();
    await prefs.setStringList(favorites, listId);
  }

  Future<List<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(favorites);
    if (stringList != null) {
      return stringList.map((e) => int.parse(e)).toList();
    }
    return [];
  }

}