import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/widgets/app_button.dart';

class ItemDetails extends StatefulWidget {
  final String? title;

  const ItemDetails({super.key, required this.title});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: widget.title!.text.color(darkFontGrey).fontFamily(bold).make(),
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imgS1,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }),
                  10.heightBox,
                  widget.title!.text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  VxRating(
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    stepInt: true,
                  ),
                  10.heightBox,
                  "\$30".text.color(redColor).fontFamily(bold).size(18).make(),
                  10.heightBox,
                  Column(
                    children: [
                      Row(
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
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity: ".text.color(darkFontGrey).make(),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                              "0"
                                  .text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          10.heightBox,
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(darkFontGrey).make(),
                              ),
                              "\$0.00"
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
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
            child: appButton(() {}, redColor, whiteColor, "Add to cart"),
          ),
        ],
      ),
    );
  }
}
