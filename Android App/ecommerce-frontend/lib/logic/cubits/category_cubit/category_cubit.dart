import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/repositories/category_repository.dart';
import 'package:ecommerce/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//khởi tạo CategoryCubit với trạng thái ban đầu
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }
  //lấy dữ liệu từ thể loại sp
  final _categoryRepository = CategoryRepository();
  //khởi tạo trạng thái thể loại sản phẩm
  void _initialize() async {
    emit(CategoryLoadingState(state.categories));
    try {
      List<CategoryModel> categories =
          await _categoryRepository.fetchAllCategories();
      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(CategoryErrorState(ex.toString(), state.categories));
    }
  }
}
