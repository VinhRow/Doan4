import 'package:ecommerce/data/models/cart/cart_item_model.dart';

import '../user/user_model.dart';

//Đơn hàng gồm có id, User, sản phẩm, trạng thái, ngày cập nhật, ngày tạo.
class OrderModel {
  String? sId;
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.updatedOn,
      this.createdOn});
  //Khởi tạo dữ liệu từ json
  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModel.fromJson(json["user"]);
    items = (json["items"] as List<dynamic>)
        .map((item) => CartItemModel.fromJson(item))
        .toList();
    status = json['status'];
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }
  //chuyển dữ liệu thành json và trả dữ liệu về
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['status'] = this.status;
    data['updatedOn'] = this.updatedOn?.toIso8601String();
    data['createdOn'] = this.createdOn?.toIso8601String();
    return data;
  }
}
