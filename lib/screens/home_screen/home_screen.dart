import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/screens/home_screen/components/featured_button.dart';
import 'package:foody/widgets/home_buttons.dart';
import 'package:get/get.dart';

import '../categories_screen.dart/category_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                height: 60,
                color: lightGrey,
                child: TextFormField(
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchAnything,
                      hintStyle: TextStyle(
                        color: textfieldGrey,
                      )),
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  return homeButton(
                    MediaQuery.of(context).size.width / 2.5,
                    MediaQuery.of(context).size.height * 0.2,
                    index == 0 ? icTodaysDeal : icFlashDeal,
                    index == 0 ? todayDeal : flashSale,
                  );
                }),
              ),
              10.heightBox,
              //second swi^per
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
              10.heightBox,
              Row(
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
              ),
              20.heightBox,
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
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: ((context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgS4,
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
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .roundedSM
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(
                        () => CategoryDetails(
                          title: categoriesList[index],
                        ),
                      );
                    });
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
