import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:get/get.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .fontFamily(bold)
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            appButton(() {
              SystemNavigator.pop();
            }, redColor, whiteColor, "Yes"),
            appButton(() {
              Navigator.pop(context);
            }, redColor, whiteColor, "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
