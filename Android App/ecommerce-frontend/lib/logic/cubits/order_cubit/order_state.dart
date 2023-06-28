import './../../../data/models/order/order_model.dart';

//định nghĩa trạng thái của đơn hàng
abstract class OrderState {
  final List<OrderModel> orders;
  OrderState(this.orders);
}

//trạng thái ban đầu của đơn hàng
class OrderInitialState extends OrderState {
  OrderInitialState() : super([]);
}

//trạng thái đang tải dữ liệu
class OrderLoadingState extends OrderState {
  OrderLoadingState(super.orders);
}

//trạng thái tải dữ liệu thành công
class OrderLoadedState extends OrderState {
  OrderLoadedState(super.orders);
}

//trạng thái tải dữ liệu thất bại
class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState(this.message, super.orders);
}
