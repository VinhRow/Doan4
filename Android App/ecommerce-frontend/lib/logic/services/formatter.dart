import 'package:intl/intl.dart';

//Định dạng đơn vị tiền tệ
class Formatter {
  static String formatPrice(num price) {
    final numberFormat = NumberFormat("###,###,### đ");
    return numberFormat.format(price);
  }

  //Định dạng kiểu ngày tháng năm
  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}
