import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/controllers/auth_controllert.dart';
import 'package:foody/screens/auth/login_screen.dart';
import 'package:foody/screens/home_screen/home.dart';
import 'package:foody/widgets/app_button.dart';
import 'package:foody/widgets/applogo_widget.dart';
import 'package:foody/widgets/bg_widget.dart';
import 'package:foody/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isChecked = false;
  var controller = Get.put(AuthController());
  // text controllers !
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  //////////
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join $appname".text.fontFamily(bold).white.size(22).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextfield(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  customTextfield(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  customTextfield(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  customTextfield(
                      title: retypePassword,
                      hint: passwordHint,
                      controller: passwordRetypeController,
                      isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgotPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termsAndCond,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : appButton(() async {
                          if (isChecked != false) {
                            controller.isLoading(true);
                            try {
                              await controller
                                  .signupMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedIn);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        }, isChecked == true ? redColor : lightGrey, whiteColor,
                              signUp)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  10.heightBox,
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: alreadyHaveAnAccount,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          ),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.to(() => const LoginScreen());
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
