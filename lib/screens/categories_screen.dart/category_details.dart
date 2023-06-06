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

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
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
                    .margin((const EdgeInsets.symmetric(horizontal: 4)))
                    .make()
                    .onTap(() {
                  switchCategory(controller.subCat[index]);
                  setState(() {});
                }),
              ),
            ),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(child: Center(child: loadingIndicator()));
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: "No products found !"
                      .text
                      .color(darkFontGrey)
                      .makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;

                return Expanded(
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
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "${data[index]['p_name']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']} TND"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index],
                                ));
                          });
                        }),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
