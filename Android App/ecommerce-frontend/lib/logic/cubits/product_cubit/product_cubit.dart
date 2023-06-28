import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//khởi tạo sản phẩm với trạng thái ban đầu
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }
  //lấy dữ liệu từ thể loại sp
  final _productRepository = ProductRepository();
  //khởi tạo trạng thái
  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      final products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
