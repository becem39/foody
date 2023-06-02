import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/product_controller.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

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
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: redColor,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outlined,
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
                        /* Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Supplements"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(14)
                                  .make(),
                            ),
                            10.heightBox,
                            const Spacer(),
                            //supplements here
                          ],
                        ),*/
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
                          ],
                        ).box.white.shadowSm.make(),
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
                controller.addToCart(
                  context: context,
                  quantity: controller.quantity.value,
                  img: data['p_images'][0],
                  title: data['p_name'],
                  price: controller.totalPrice.value,
                );
                VxToast.show(context, msg: "Added to cart");
              }, redColor, whiteColor, "Add to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
