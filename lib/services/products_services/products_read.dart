import 'dart:convert';

import 'package:infinity_scroll/configs/api_configs.dart';
import 'package:infinity_scroll/models/api/api_response.dart';
import 'package:infinity_scroll/models/product/product.dart';
import 'package:http/http.dart' as http;

class ProductsRead {
  Future<ApiResponse<ProductResponse>> getListItems(int skip, int limit) async {
    try {
      var response = await http.get(
        Uri.parse(
          ApiConfigs.listItems(skip, limit, select: "title,price,images"),
        ),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return Success(data: ProductResponse.fromJson(data));
      } else {
        return Fail(message: "Fail", code: 404);
      }
    } catch (e) {
      return Error(message: 'Error $e');
    }
  }

  Future<ApiResponse<ProductResponse>> getListItemsSearch(
      int skip,
      int limit,
      String searchValue,
      ) async {
    try {
      var response = await http.get(
        Uri.parse(
          ApiConfigs.listItemsSearch(
            skip,
            limit,
            searchValue,
            select: "title,price,images",
          ),
        ),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return Success(data: ProductResponse.fromJson(data));
      } else {
        return Fail(message: "Fail", code: 404);
      }
    } catch (e) {
      return Error(message: 'Error $e');
    }
  }
}
