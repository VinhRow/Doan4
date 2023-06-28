import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/category/category_model.dart';

// Cart Repository dùng để tương tác với dữ liệu trong giỏ hàng
class CartRepository {
  final _api = Api();

  //Lấy dữ liệu giỏ hàng bằng Id của người dùng
  Future<List<CartItemModel>> fetchCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  //Thêm sản phẩm vào giỏ hàng
  Future<List<CartItemModel>> addToCart(
      CartItemModel cartItem, String userId) async {
    try {
      Map<String, dynamic> data = cartItem.toJson();
      data["user"] = userId;

      Response response =
          await _api.sendRequest.post("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  // Xóa sản phẩm khỏi giỏ hàng
  Future<List<CartItemModel>> removeFromCart(
      String productId, String userId) async {
    try {
      Map<String, dynamic> data = {"product": productId, "user": userId};

      Response response =
          await _api.sendRequest.delete("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
