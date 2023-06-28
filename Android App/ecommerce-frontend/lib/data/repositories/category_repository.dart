import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/category/category_model.dart';

// CategoryRepository dùng để tương tác dữ liệu với loại sản phẩm
class CategoryRepository {
  final _api = Api();
  //Lấy thông tin tất cả thể loại sản phẩm
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
