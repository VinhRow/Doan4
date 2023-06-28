import 'package:ecommerce/data/models/cart/cart_item_model.dart';

// Định nghĩa các trang thái của giỏ hàng
abstract class CartState {
  final List<CartItemModel> items;
  CartState(this.items);
}

//Trạng thái ban đầu của giỏ hàng
class CartInitialState extends CartState {
  CartInitialState() : super([]);
}

//trạng tháu đang tải dữ liệu
class CartLoadingState extends CartState {
  CartLoadingState(super.items);
}

// trạng tháu tải dữ liệu thành công
class CartLoadedState extends CartState {
  CartLoadedState(super.items);
}

//Trạng thái khi giỏ hàng xảy ra lỗi
class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message, super.items);
}
