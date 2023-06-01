import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/controllers/product_controller.dart';
import 'package:foody/screens/categories_screen.dart/category_details.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoriesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoriesImages[index],
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index]
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  controller.getSubCategories(categoriesList[index]);
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(
                    () => CategoryDetails(
                      title: categoriesList[index],
                    ),
                  );
                });
              }),
        ),
      ),
    ));
  }
}
