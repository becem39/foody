import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foody/consts/consts.dart';
import 'package:get/get.dart';

import '../screens/home_screen/home.dart';
import '../screens/waiter _screens/waiter_home.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

//text controllers !

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final String uid = userCredential.user!.uid;

      final userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final String role = userData['role'];

      if (role == 'client') {
        Get.offAll(() => const Home());
      } else if (role == 'waiter') {
        Get.offAll(() => const WaiterHome());
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

/*
 Future<void> loginMethod({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = userCredential.user!.uid;

      // Get the user data from Firestore
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final String role = userData['role'];

      // Check the role and redirect the user accordingly
      if (role == 'client') {
        // Redirect to client home page
        Get.offAll(() => const Home());
      } else if (role == 'staff') {
        // Redirect to staff home page
        Get.offAll(() => const WaiterHome());
      }
    } catch (e) {
      print('Error logging in: $e');
      // Handle login error
    }
  }

*/
  //signup !
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'role': 'client',
      'id': currentUser!.uid,
      'cart_count': '00',
      'wishlist_count': '00',
      'order_count': '00',
    });
  }

  //signout

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
