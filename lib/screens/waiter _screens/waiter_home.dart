import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/home_controller.dart';
import 'package:foody/screens/waiter%20_screens/waiter_cart.dart';
import 'package:foody/screens/waiter%20_screens/waiter_home_screen.dart';
import 'package:foody/screens/waiter%20_screens/waiter_order.dart';
import 'package:foody/widgets/exit_dialog.dart';
import 'package:get/get.dart';
import 'package:foody/controllers/auth_controllert.dart';

import '../auth/login_screen.dart';

class WaiterHome extends StatelessWidget {
  const WaiterHome({super.key});

  @override
  Widget build(BuildContext context) {
        var auth = Get.put(AuthController());
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
        label: "Orders",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart,
      ),
       const BottomNavigationBarItem(
        icon: Icon(Icons.logout,),
        label: "Logout",
        
      ),
 
    ];
    var navBody = [
      const WaiterHomeScreen(),
      const WaiterOrdersScreen(),
      const WaiterCartScreen(),

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
if (value == 3) {
                // Logout functionality
                auth.signOutMethod(context);
                Get.offAll(() => const LoginScreen());
              }
              else
            {  controller.currentNavIndex.value = value;}
            },
          ),
        ),
      ),
    );
  }
}
