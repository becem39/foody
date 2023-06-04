import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foody/consts/colors.dart';
import 'package:foody/consts/consts.dart';

Widget orderStatus({
  required IconData icon,
  required Color color,
  required String title,
   required showDone,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(const EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround ,
        children: [
          Text(
            title,
            style: const TextStyle(color: darkFontGrey),
          ),
          if (showDone) const Icon(Icons.done, color: redColor),
        ],
      ),
    ),
  );
}
