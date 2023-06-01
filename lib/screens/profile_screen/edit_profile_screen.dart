import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/profile_controller.dart';

import 'package:foody/widgets/app_button.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:foody/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    /*  controller.nameController.text = data['name'];
    controller.passwordController.text = data['password'];*/
    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            appButton(() {
              controller.changeImage(context);
            }, redColor, whiteColor, "Change"),
            const Divider(),
            20.heightBox,
            customTextfield(
                hint: nameHint,
                controller: controller.nameController,
                title: name,
                isPass: false),
            10.heightBox,
            customTextfield(
                hint: password,
                controller: controller.oldPasswordController,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextfield(
                hint: password,
                controller: controller.newPasswordController,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: appButton(() async {
                      controller.isLoading(true);
//if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = data['imageUrl'];
                      }

                      //if old pass matches db
                      if (data['password'] ==
                          controller.oldPasswordController.text) {
                        await controller.changeAuthPassword(
                          email: data['email'],
                          password: controller.oldPasswordController.text,
                          newPassword: controller.newPasswordController,
                        );
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.newPasswordController.text,
                          imgUrl: controller.profileImageLink,
                        );
                        VxToast.show(context, msg: "updated");
                      } else {
                        VxToast.show(context, msg: "Wrong old password");
                        controller.isLoading(false);
                      }
                    }, redColor, whiteColor, "Save")),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(
              const EdgeInsets.only(top: 50, left: 12, right: 12),
            )
            .rounded
            .make(),
      ),
    ));
  }
}
