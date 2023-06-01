import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody/models/category_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  /* var subCat = [];
  getSubCategories(title) async {
  
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subCategories) {
      subCat.add(e);
    }
  }*/
  var subCat = <String>[].obs;

  Future<void> getSubCategories(String title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");

    var decoded = categoryModelFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    subCat.value = s.isNotEmpty ? s[0].subCategories : [];
  }
}
