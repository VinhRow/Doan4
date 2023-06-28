import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/models/order/order_model.dart';

// OrderRepository dùng để tương tác dữ liệu trong đơn hàng.
class OrderRepository {
  final _api = Api();
  //Lấy thông tin đơn hàng bằng id của người dùng
  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/order/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  // Tạo đơn hàng mới
  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest
          .post("/order", data: jsonEncode(orderModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
