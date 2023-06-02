import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/home_controller.dart';
import 'package:foody/screens/cart_screen/cart_screen.dart';
import 'package:foody/screens/categories_screen.dart/category_screen.dart';
import 'package:foody/screens/home_screen/home_screen.dart';
import 'package:foody/screens/profile_screen/profile_screen.dart';
import 'package:foody/widgets/exit_dialog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account,
      ),
    ];
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => exitDialog(context),
          barrierDismissible: false,
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value)),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItems,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
