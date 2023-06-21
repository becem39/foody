import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/screens/cart_screen/shipping_screen.dart';
import 'package:foody/screens/waiter%20_screens/waiter_home.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:foody/widgets/loading_indicator.dart';
import 'package:get/get.dart';

class WaiterCartScreen extends StatelessWidget {
  const WaiterCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: appButton(()async {
             await controller.placeMyOrder(controller.totalPrice);
            await controller.clearCart();

            Get.offAll(const WaiterHome());
          }, redColor, whiteColor, "Confirm order"),
        ),
        appBar: AppBar(
          backgroundColor: redColor,
          automaticallyImplyLeading: false,
          title: "Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              leading: Image.network(
                                '${data[index]['img']}',
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              title:
                                  '${data[index]['title']} ${data[index]['quantity']}'
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                              subtitle: '${data[index]['price']} TND           table    ${data[index]['table_num']}  '
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              trailing: const Icon(
                                Icons.delete,
                                color: redColor,
                              ).onTap(() {
                                FirestoreServices.deleteDocument(
                                    data[index].id);
                              }),
                            );
                          }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Text(
                            controller.totalPrice.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: darkFontGrey,
                              fontFamily: 'bold',
                            ),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .width(context.screenWidth - 60)
                          .color(lightGolden)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      /*   SizedBox(
                        width: context.screenWidth - 50,
                        child: appButton(
                            () {}, redColor, whiteColor, "Confirm order"),
                      )*/
                    ],
                  ),
                );
              }
            }));
  }
}
