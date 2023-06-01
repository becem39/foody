import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foody/screens/profile_screen/edit_profile_screen.dart';

import 'package:foody/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: darkFontGrey,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        fontFamily: regular,
      ),
      initialRoute: '/SplashScreen',
      getPages: [
        GetPage(name: '/SplashScreen', page: () => const SplashScreen()),
        GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
        GetPage(name: '/SignupScreen', page: () => const SignupScreen()),
        GetPage(
            name: '/EditProfileScreen', page: () => const EditProfileScreen()),
        GetPage(name: '/Home', page: () => const Home()),
      ],
    );
  }
}
