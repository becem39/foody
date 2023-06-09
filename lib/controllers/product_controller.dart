import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/models/category_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var subCat = <String>[].obs;
  var isFav = false.obs;

  Future<void> getSubCategories(String title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");

    var decoded = categoryModelFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    subCat.value = s.isNotEmpty ? s[0].subCategories : [];
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, quantity, price, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'quantity': quantity,
      'price': price,
      // 'total_price': totalPrice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  waddToCart({title, img, quantity, price, context, table_num}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'quantity': quantity,
      'price': price,
      'table_num': table_num,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetvalues() {
    totalPrice.value = 0;
    quantity.value = 0;
    isFav.value = false;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: 'Added to wishlist');
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: 'Removed from wishlist');
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
