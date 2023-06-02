import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/product_controller.dart';
import 'package:foody/screens/categories_screen.dart/item_details.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../widgets/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No products found !".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.subCat.length,
                          (index) => controller.subCat[index].text
                              .size(12)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .white
                              .rounded
                              .size(120, 60)
                              .margin(
                                  (const EdgeInsets.symmetric(horizontal: 4)))
                              .make()),
                    ),
                  ),
                  20.heightBox,
                  //items
                  Expanded(
                    child: Container(
                      color: lightGrey,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                          
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_images'][0],
                            
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "Price \$20"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadowSm
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => const ItemDetails(
                                    title: 'title here',
                                  ));
                            });
                          }),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
