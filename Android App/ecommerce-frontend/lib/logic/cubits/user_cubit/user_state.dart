import 'package:ecommerce/data/models/user/user_model.dart';

//định nghĩa trạng thái người dùng
abstract class UserState {}

//trạng thái ban đầu
class UserInitialState extends UserState {}

//Trạng thái đang tải dữ liệu
class UserLoadingState extends UserState {}

//trạng thái đã đăng nhập
class UserLoggedInState extends UserState {
  final UserModel userModel;
  UserLoggedInState(this.userModel);
}

//trạng thái đã đăng xuất
class UserLoggedOutState extends UserState {}

//Trạng thái tải dữ liệu người dùng thất bại
class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
