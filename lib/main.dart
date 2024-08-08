import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/burger_details.dart';
import 'package:food_ordering_app/Screens/burgers_screen.dart';
import 'package:food_ordering_app/Screens/check_box.dart';
import 'package:food_ordering_app/Screens/radio_button.dart';
import 'package:food_ordering_app/auth/login_screen.dart';
import 'package:food_ordering_app/auth/register_screen.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:food_ordering_app/Screens/home_page.dart';
import 'package:food_ordering_app/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      // DevicePreview(
      //   enabled: true,
      //   builder: (context) => const FoodOrderingApp(),
      // ),

      FoodOrderingApp());
}

class FoodOrderingApp extends StatefulWidget {
  const FoodOrderingApp({super.key});

  @override
  State<FoodOrderingApp> createState() => _FirebaseLearningState();
}

class _FirebaseLearningState extends State<FoodOrderingApp> {
  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const SplashScreen()
          : HomePage(),
      routes: {
        "loginScreen": (context) => const LoginScreen(),
        "registerScreen": (context) => RegisterScreen(),
        "homeScreen": (context) => HomePage(),
        "burgerScreen": (context) => BurgersScreen(),
        "burgerDetailsScreen": (context) => BurgerDetails(),
        "radioButton": (context) => MyRadioButton(),
        'ProductSelectionScreen': (context) => ProductSelectionScreen(),
      },
    );
  }
}
