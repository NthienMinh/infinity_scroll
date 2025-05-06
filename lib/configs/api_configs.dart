class ApiConfigs {
  static String listItems(int skip, int limit, {String select = ""}) {
    return "https://dummyjson.com/products?limit=$limit&skip=$skip${select.isEmpty ? "" : "&select=$select"}";
  }

  static String listItemsSearch(int skip, int limit,String searchValue, {String select = ""}) {
    return "https://dummyjson.com/products/search?q=$searchValue&limit=$limit&skip=$skip${select.isEmpty ? "" : "&select=$select"}";
  }
}
