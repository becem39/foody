import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(100, 100)
      .padding(const EdgeInsets.all(0))
      .rounded
      .make();
}
