import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_product_state.dart';

//khởi tạo trạng thái ban đầu của đối tượng sản phẩm trong thể loại
class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }
  //lấy dữ liệu sản phẩm trong loại sản phẩm
  final _productRepository = ProductRepository();
  //khởi tạo trạng thái của
  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products =
          await _productRepository.fetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(ex.toString(), state.products));
    }
  }
}
