import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';

Widget appButton(onPress, Color color, Color textColor, String title) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title.text.color(textColor).fontFamily(bold).make(),
  );
}
