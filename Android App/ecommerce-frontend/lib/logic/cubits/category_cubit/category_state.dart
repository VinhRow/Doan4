import 'package:ecommerce/data/models/category/category_model.dart';

//định nghĩa trạng thái của loại sản phẩm
abstract class CategoryState {
  final List<CategoryModel> categories;
  CategoryState(this.categories);
}

// Trạng thái ban đầu của
class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super([]);
}

// Trạng thái đang tải dữ liệu
class CategoryLoadingState extends CategoryState {
  CategoryLoadingState(super.categories);
}

//trạng thái đã tải dữ liệu thành công
class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(super.categories);
}

//trạng thái gặp lỗi
class CategoryErrorState extends CategoryState {
  final String message;
  CategoryErrorState(this.message, super.categories);
}
