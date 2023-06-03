import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.0;
  late dynamic productSnapshot;
  var products = [];
//text controllers for shipping
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var phoneController = TextEditingController();
  calculate(data) {
    totalPrice = 0.0;
    for (var j = 0; j < data.length; j++) {
      totalPrice += double.parse(data[j]['price'].toString());
    }
  }

  ////////////////
  placeMyOrder(totalAmount) async {
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code':'222222',
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      "shipping_method": "Delivery",
      'order_placed': true,
      'total_amount': totalAmount,
      'order_confirmed':false,
      'order_delivered':false,
      'orders': FieldValue.arrayUnion(products),
    });
  }

/////////////////////
  getProductDetails() {
    products.clear();
    for (var j = 0; j < productSnapshot.length; j++) {
      products.add({
        'img': productSnapshot[j]['img'],
        'quantity': productSnapshot[j]['quantity'],
        'title': productSnapshot[j]['title'],
      });
    }
  }
}
