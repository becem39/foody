import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/consts/lists.dart';
import 'package:foody/controllers/auth_controllert.dart';
import 'package:foody/screens/auth/signup_screen.dart';
import 'package:foody/screens/home_screen/home.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:foody/widgets/applogo_widget.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:foody/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(22).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextfield(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController),
                  customTextfield(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgotPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  //logiin button
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : appButton(() async {
                          controller.isLoading(true);
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedIn);
                              Get.to(() => const Home());
                            } else {
                              controller.isLoading(false);
                            }
                          });
                          //
                        }, redColor, whiteColor, login)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  appButton(() {
                    Get.to(() => const SignupScreen());
                  }, lightGolden, redColor, signUp)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .make(),
            ),
            10.heightBox,
            loginWith.text.color(fontGrey).make(),
            5.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: lightGrey,
                          child: Image.asset(
                            socialIconList[index],
                            width: 30,
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    ));
  }
}
