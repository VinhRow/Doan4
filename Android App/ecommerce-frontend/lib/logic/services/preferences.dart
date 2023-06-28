import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

//chứa các phương thức tĩnh để làm việc với SharedPreferences
class Preferences {
  //lưu email và password
  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
    log("Details saved!");
  }

  //trả về thông tin địa chỉ email và mật khẩu
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {"email": email, "password": password};
  }

  //xóa tất cả dữ liệu trong SharedPreferences
  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
