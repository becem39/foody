import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/product_controller.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:get/get.dart';

class WaiterItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const WaiterItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    Get.find<ProductController>();
    var tablenum = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        controller.resetvalues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetvalues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
            color: darkFontGrey,
          ),
          backgroundColor: whiteColor,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: darkFontGrey,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_images'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']} TND"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity: ".text.color(darkFontGrey).make(),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.decreaseQuantity();
                                      controller.calculateTotalPrice(
                                          double.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    controller.quantity.value.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: darkFontGrey,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.increaseQuantity(
                                          int.parse(data['p_quantity']));

                                      controller.calculateTotalPrice(
                                          double.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  10.heightBox,
                                  "${data['p_quantity']} available"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ],
                              ),
                            ),
                            10.heightBox,
                            Obx(
                              () => Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total: "
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                  ),
                                  "${controller.totalPrice.value} Tnd"
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ),
                            10.heightBox,
                
                          ],
                        ).box.white.shadowSm.make(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Table number: ".text.color(darkFontGrey).make(),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: tablenum,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
            10.heightBox,
            SizedBox(
              width: double.infinity,
              height: 60,
              child: appButton(() {
                if (controller.quantity.value > 0) {
                  controller.waddToCart(
                    context: context,
                    quantity: controller.quantity.value,
                    img: data['p_images'][0],
                    title: data['p_name'],
                    price: controller.totalPrice.value,
                    table_num: tablenum.text,
                  );
                  VxToast.show(context, msg: "Added to cart");
                } else {
                  VxToast.show(context, msg: "Minimum 1 product");
                }
              }, redColor, whiteColor, "Add to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
