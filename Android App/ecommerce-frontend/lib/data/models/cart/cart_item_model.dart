import '../product/product_model.dart';

//Tạo lớp cart có các thuộc tính như Sản phẩm, số lượng, id.
class CartItemModel {
  ProductModel? product;
  int? quantity;
  String? sId;

  CartItemModel({this.quantity, this.sId, this.product});
  //Khởi tạo dữ liệu từ Json
  CartItemModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json["product"]);
    quantity = json['quantity'];
    sId = json['_id'];
  }
  //Chuyển dữ liệu thành Json và trả dữ liệu về
  Map<String, dynamic> toJson({bool objectMode = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = (objectMode == false) ? product!.sId : product!.toJson();
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
