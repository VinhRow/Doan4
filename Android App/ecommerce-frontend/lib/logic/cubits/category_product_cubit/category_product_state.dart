import 'package:ecommerce/data/models/product/product_model.dart';

//định nghĩa trạng thái của sản phẩm trong thể loạn
abstract class CategoryProductState {
  final List<ProductModel> products;
  CategoryProductState(this.products);
}

//trạng thái ban đầu
class CategoryProductInitialState extends CategoryProductState {
  CategoryProductInitialState() : super([]);
}

//trạng thái đang tải dữ liệu
class CategoryProductLoadingState extends CategoryProductState {
  CategoryProductLoadingState(super.products);
}

//trạng thái đã tải dữ liệu thành công
class CategoryProductLoadedState extends CategoryProductState {
  CategoryProductLoadedState(super.products);
}

//trạng thái tải dữ liệu không thành công
class CategoryProductErrorState extends CategoryProductState {
  final String message;
  CategoryProductErrorState(this.message, super.products);
}
