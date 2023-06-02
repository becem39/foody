import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.0;
  calculate(data) {
    totalPrice = 0.0;
    for (var j = 0; j < data.length; j++) {
      totalPrice += double.parse(data[j]['price'].toString());
    }
  }
}
