import 'dart:developer';
import 'package:ecommerce/core/routes.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/category_cubit/category_cubit.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});
  //sử dụng kiến trúc Bloc để quản lý trạng thái
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //Đăng ký các Bloc Cubit để quản lý trạng thái và tương tác dữ liệu
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(
            create: (context) =>
                CartCubit(BlocProvider.of<UserCubit>(context))),
        BlocProvider(
            create: (context) => OrderCubit(
                  BlocProvider.of<UserCubit>(context),
                  BlocProvider.of<CartCubit>(context),
                )),
      ],
      //Cung cấp các thiết lập chung cho ứng dụng như giao diện, định tuyến và cấu hình gỡ lỗi
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes.defaultTheme,
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: SplashScreen.routeName),
    );
  }
}

//Sử dụng để theo dõi các sự kiện trong quá trình sử dụng Cubit
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
