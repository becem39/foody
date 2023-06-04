import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/screens/home_screen/home.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:foody/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: redColor,
        title: "Shipping info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: appButton(() async {
          if ((controller.addressController.text.length < 4) ||
              (controller.cityController.text.length < 3) ||
              (controller.stateController.text.length < 4) ||
              (controller.phoneController.text.length != 8)) {
            VxToast.show(context, msg: "Please fill the form");
          } else {
            await controller.placeMyOrder(controller.totalPrice);
            await controller.clearCart();

            Get.offAll(const Home());
          }
        }, redColor, whiteColor, "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          customTextfield(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController),
          customTextfield(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController),
          customTextfield(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController),
          customTextfield(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController),
        ]),
      ),
    );
  }
}
