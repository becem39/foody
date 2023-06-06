// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));



class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

 
}

class Category {
  String name;
  List<String> subCategories;

  Category({
    required this.name,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subCategories: List<String>.from(json["subCategories"].map((x) => x)),
      );


}
