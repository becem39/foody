import 'package:foody/consts/consts.dart';

class FirestoreServices {
  //get user data

  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }
}
