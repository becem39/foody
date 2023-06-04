import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/screens/orders_screen/components/order_place_details.dart';
import 'package:foody/screens/orders_screen/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details".text.fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  icon: Icons.done,
                  color: redColor,
                  title: "Order placed",
                  showDone: data['order_placed']),
              orderStatus(
                  icon: Icons.thumb_up,
                  color: Vx.blue900,
                  title: "Order confirmed",
                  showDone: data['order_confirmed']),
              orderStatus(
                  icon: Icons.done_all_rounded,
                  color: Colors.purple,
                  title: "Order delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                      data1: data['order_code'], title1: 'order code'),
                  /*  orderPlaceDetails(
                      title1: "Order date ",
                      data1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate()))),*/
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Adress".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.make(),
              const Divider(),
              10.heightBox,
              "Order products"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    children: [
                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                        
                          data1: data['orders'][index]['quantity']),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .shadowMd
                  .margin(const EdgeInsets.only(bottom: 4))
                  .white
                  .make(),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
