import 'package:flutter/material.dart';
import 'package:foody/consts/colors.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
