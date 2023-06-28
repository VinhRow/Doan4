import 'package:ecommerce/data/models/product/product_model.dart';

//định nghĩa trạng thái của đơn hàng
abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

//trạng thái ba đầu
class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

//trạng thái đang tải dữ liệu
class ProductLoadingState extends ProductState {
  ProductLoadingState(super.products);
}

//trạng thái tải dữ liệu thành công
class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products);
}

// trạng thái tải dữ liệu thất bại
class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products);
}
