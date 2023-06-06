import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/product_controller.dart';
import 'package:foody/screens/categories_screen.dart/item_details.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: redColor,
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return 'No products found'.text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  children: filtered
                      .mapIndexed(
                        (currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['p_images'][0],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            ' ${filtered[index]['p_name']}'
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                            10.heightBox,
                            ' ${filtered[index]['p_price']} TND'
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .outerShadowSm
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }),
                      )
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
