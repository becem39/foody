import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/controllers/home_controller.dart';
import 'package:foody/screens/categories_screen.dart/item_details.dart';
import 'package:foody/screens/home_screen/components/featured_button.dart';
import 'package:foody/screens/home_screen/components/search_screen.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:foody/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 200,
                  enlargeCenterPage: true,
                  itemCount: sliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      sliderList[index],
                      fit: BoxFit.cover,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(const EdgeInsets.symmetric(horizontal: 0))
                        .make();
                  }),
              10.heightBox,
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  return homeButton(
                    MediaQuery.of(context).size.width / 2.5,
                    MediaQuery.of(context).size.height * 0.2,
                    index == 0 ? icTodaysDeal : icFlashDeal,
                    index == 0 ? todayDeal : flashSale,
                  );
                }),
              ),*/
              10.heightBox,
              //second swi^per
              /*      VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 200,
                  enlargeCenterPage: true,
                  itemCount: secondSliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      secondSliderList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(const EdgeInsets.symmetric(horizontal: 0))
                        .make();
                  }),*/
              10.heightBox,

              /*  Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: homeButton(
                      MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.height * 0.2,
                      index == 0
                          ? icTopCategories
                          : index == 1
                              ? icBrands
                              : icTopSeller,
                      index == 0
                          ? topCategories
                          : index == 1
                              ? brand
                              : topSellers,
                    ),
                  );
                }),
              ),*/
              //   20.heightBox,
              //featured taw
              Align(
                alignment: Alignment.centerLeft,
                child: featuredCategories.text
                    .color(darkFontGrey)
                    .size(18)
                    .fontFamily(semibold)
                    .make(),
              ),
              20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    2,
                    (index) => Column(
                      children: [
                        featuredButton(
                            featuredTitles[index], featuredImages1[index]),
                        10.heightBox,
                        featuredButton(
                            featuredTitles2[index], featuredImages2[index]),
                      ],
                    ),
                  ).toList(),
                ),
              ),
              20.heightBox,
              VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 200,
                  enlargeCenterPage: true,
                  itemCount: secondSliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      secondSliderList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(const EdgeInsets.symmetric(horizontal: 0))
                        .make();
                  }),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder(
                          stream: FirestoreServices.getFeaturedProducts(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingIndicator();
                            } else if (snapshot.data!.docs.isEmpty) {
                              return "No featured products".text.makeCentered();
                            } else {
                              var featuredData = snapshot.data!.docs;
                              return Row(
                                children: List.generate(
                                  featuredData.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_images'][0],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(bold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${featuredData[index]['p_price']} TND"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .roundedSM
                                        .padding(const EdgeInsets.all(8))
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                    }),
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
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
                              Get.to(() => ItemDetails(
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
/* 
 
*/