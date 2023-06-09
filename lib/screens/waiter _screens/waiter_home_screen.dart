import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/controllers/home_controller.dart';
import 'package:foody/screens/categories_screen.dart/item_details.dart';
import 'package:foody/screens/home_screen/components/featured_button.dart';
import 'package:foody/screens/home_screen/components/search_screen.dart';
import 'package:foody/screens/waiter%20_screens/waiter_item_details.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:foody/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class WaiterHomeScreen extends StatelessWidget {
  const WaiterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    Get.put<ProductController>(ProductController());
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      padding: const EdgeInsets.all(12),
      height: context.screenHeight,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                // height: 60,
                color: lightGrey,
                child: TextFormField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search).onTap(() {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScreen(
                                title: controller.searchController.text,
                              ));
                        }
                      }),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchAnything,
                      hintStyle: const TextStyle(
                        color: textfieldGrey,
                      )),
                ),
              ),
  
    
    
      

  
              20.heightBox,
/////////featured products
              Container(
                color: whiteColor,
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Featured products"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                  ],
                ),
              ),
              20.heightBox,
              //all products
              Align(
                alignment: Alignment.centerLeft,
                child: allProducts.text
                    .color(darkFontGrey)
                    .size(18)
                    .fontFamily(semibold)
                    .make(),
              ),
              20.heightBox,
              StreamBuilder(
                  stream: FirestoreServices.allProducts(),
                  builder: ((BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else {
                      var allProductsData = snapshot.data!.docs;
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allProductsData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: ((context, index) {
                            return Column(
                              key: ValueKey<String>('product_$index'),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  allProductsData[index]['p_images'][0],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                ' ${allProductsData[index]['p_name']}'
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                                10.heightBox,
                                ' ${allProductsData[index]['p_price']} TND'
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
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => WaiterItemDetails(
                                    title:
                                        "${allProductsData[index]['p_name']}",
                                    data: allProductsData[index],
                                  ));
                            });
                          }));
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
