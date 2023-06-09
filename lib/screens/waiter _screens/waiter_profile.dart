import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/controllers/auth_controllert.dart';
import 'package:foody/controllers/profile_controller.dart';
import 'package:foody/screens/auth/login_screen.dart';
import 'package:foody/screens/orders_screen/orders_screen.dart';
import 'package:foody/screens/profile_screen/components/detail_card.dart';
import 'package:foody/screens/profile_screen/edit_profile_screen.dart';
import 'package:foody/screens/waiter%20_screens/waiter_order.dart';
import 'package:foody/services/firestore_services.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:foody/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../wishlist_screen/wishlist_screen.dart';

class WaiterProfileScreen extends StatelessWidget {
  const WaiterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    //edit profile
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: whiteColor,
                          )).onTap(() {
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfileScreen(
                              data: data,
                            ));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == '' &&
                                  controller.profileImgPath.isEmpty
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : data['imageUrl'] != '' &&
                                      controller.profileImgPath.isEmpty
                                  ? Image.network(
                                      data['imageUrl'],
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.file(
                                      File(controller.profileImgPath.value),
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                          10.heightBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signOutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: "Logout"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make()),
                        ],
                      ),
                    ),
                    20.heightBox,

                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var countData = snapshot.data as List<dynamic>;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailCard(context.screenWidth / 3,
                                    countData[0].toString(), "in your cart"),
                                detailCard(context.screenWidth / 3,
                                    countData[2].toString(), "your orders"),
                              ],
                            );
                          }
                        })),

                    Expanded(
                      child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.asset(
                                    profileButtonIcon[index],
                                    width: 22,
                                  ),
                                  title: profileButtonList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(
                                            () => const WaiterOrdersScreen());
                                        break;
                                      case 1:
                                        break;
                                    }
                                  },
                                );
                              },
                              separatorBuilder: ((context, index) {
                                return const Divider(
                                  color: lightGrey,
                                );
                              }),
                              itemCount: profileButtonIcon.length)
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make(),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
