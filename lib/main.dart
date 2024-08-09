import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/admin_home_page.dart';
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
        'AdminHomePage': (context) => AdminHomePage(),
      },
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/Test%20Screens/admin_home_page.dart';
// import 'package:food_ordering_app/auth/login_screen.dart';
// import 'package:food_ordering_app/auth/register_screen.dart';
// import 'package:food_ordering_app/firebase_options.dart';
// import 'package:food_ordering_app/Screens/burger_details.dart';
// import 'package:food_ordering_app/Screens/burgers_screen.dart';
// import 'package:food_ordering_app/Screens/check_box.dart';
// import 'package:food_ordering_app/Screens/radio_button.dart';
// import 'package:food_ordering_app/Screens/home_page.dart';
// import 'package:food_ordering_app/Screens/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//       // DevicePreview(
//       //   enabled: true,
//       //   builder: (context) => const FoodOrderingApp(),
//       // ),
//       FoodOrderingApp());
// }

// class FoodOrderingApp extends StatefulWidget {
//   const FoodOrderingApp({super.key});

//   @override
//   State<FoodOrderingApp> createState() => _FoodOrderingAppState();
// }

// class _FoodOrderingAppState extends State<FoodOrderingApp> {
//   late Future<Widget> _homePage;

//   @override
//   void initState() {
//     super.initState();
//     _homePage = _getHomePage();
//   }

//   Future<Widget> _getHomePage() async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return const SplashScreen();
//     }

//     DocumentSnapshot userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();

//     if (userDoc.exists) {
//       String role = userDoc.get('rool');
//       if (role == 'admin') {
//         return const AdminHomePage(); // Replace with your admin home page
//       } else {
//         return HomePage(); // Replace with your user home page
//       }
//     } else {
//       return const SplashScreen(); // Fallback in case user document doesn't exist
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder<Widget>(
//         future: _homePage,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return snapshot.data!;
//           } else {
//             return const SplashScreen();
//           }
//         },
//       ),
//       routes: {
//         "loginScreen": (context) => const LoginScreen(),
//         "registerScreen": (context) => RegisterScreen(),
//         "homeScreen": (context) => HomePage(),
//         "burgerScreen": (context) => BurgersScreen(),
//         "burgerDetailsScreen": (context) => BurgerDetails(),
//         "radioButton": (context) => MyRadioButton(),
//         'ProductSelectionScreen': (context) => ProductSelectionScreen(),
//       },
//     );
//   }
// }
