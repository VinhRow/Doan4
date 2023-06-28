import 'dart:async';

import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../user_cubit/user_cubit.dart';
import '../user_cubit/user_state.dart';
import './../../../data/repositories/order_repository.dart';

//khởi tạo OrderCubit với trạng thái ban đầu
class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;

  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    // lấy dữ liệu đơn hàng
    _handleUserState(_userCubit.state);

    // Nhận các thay đổi của User
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }
  //thay đổi trạng thái người dùng
  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();
  //tải danh sách đơn hàng cho người dùng và cập nhật trạng thái Cubit
  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
    }
  }

  //tạo đơn hàng mới.
  Future<bool> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return false;
      }

      OrderModel newOrder = OrderModel(
          items: items,
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == "pay-on-delivery")
              ? "order-placed"
              : "payment-pending");
      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [order, ...state.orders];

      emit(OrderLoadedState(orders));

      // Clear the giỏ hàng
      _cartCubit.clearCart();

      return true;
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
