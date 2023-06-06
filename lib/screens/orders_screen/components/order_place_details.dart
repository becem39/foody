import 'package:flutter/widgets.dart';
import 'package:foody/consts/consts.dart';

Widget orderPlaceDetails({title1, data1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "  $data1".text.color(redColor).fontFamily(semibold).make(),
      
          ],
        ),
      ],
    ),
  );
}
