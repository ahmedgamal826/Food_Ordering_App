import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/coffee.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/lemonade_juice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/orange_juice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/pepsi.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/strawberry_juice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/tea.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Drinks%20Screens/water.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/fish_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/meat_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/pasta_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/sushi_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/burger_+_fries_last.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/burger_+_pepsi.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/chicken_+_rice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/pasta_+_chicken.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/fish_+_rice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Popular%20Offers/meat_+_juice.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Sweets%20Screens/chocolate_cake.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Sweets%20Screens/cupcake.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Sweets%20Screens/donuts.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Sweets%20Screens/ice_cream.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Sweets%20Screens/waffle.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_home_page.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/Screens/check_box.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/chicken_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/pizza_details_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/pizza_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';
import 'package:food_ordering_app/Screens/radio_button.dart';
import 'package:food_ordering_app/Screens/splash_screen.dart';
import 'package:food_ordering_app/auth/auth_services.dart';
import 'package:food_ordering_app/auth/login_or_register.dart';
import 'package:food_ordering_app/auth/login_page.dart';
import 'package:food_ordering_app/auth/register_page.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // runApp(
  //     // DevicePreview(
  //     //   enabled: true,
  //     //   builder: (context) => const FoodOrderingApp(),
  //     // ),

  //     FoodOrderingApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const FoodOrderingApp(),
  ));
}

class FoodOrderingApp extends StatefulWidget {
  const FoodOrderingApp({super.key});

  @override
  State<FoodOrderingApp> createState() => _FirebaseLearningState();
}

class _FirebaseLearningState extends State<FoodOrderingApp> {
  late Future<Widget> _homePage;

  @override
  void initState() {
    super.initState();
    _homePage = _getHomePage();
  }

  Future<Widget> _getHomePage() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SplashScreen();
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user_app')
        .doc(user.uid)
        .get();

    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      String role = userDoc.get('rool');
      if (role == 'user') {
        return UserHomePage(); // Replace with your admin home page
      }
    }

    // if (userDoc.exists) {
    //   String login = userDoc.get('login');
    //   if (login == 'google') {
    //     return HomePage(); // Replace with your admin home page
    //   }
    // }

    if (adminDoc.exists) {
      String role = adminDoc.get('rool');
      if (role == 'admin') {
        return AdminHomePage(); // Replace with your admin home page
      }
      {
        return SplashScreen(); // Replace with your user home page
      }
    } else {
      return SplashScreen(); // Fallback in case user document doesn't exist
    }
  }

  // void initState() {
  //   // FirebaseAuth.instance.userChanges().listen((User? user) {
  //   //   if (user == null) {
  //   //     print('User is currently signed out!');
  //   //   } else {
  //   //     print('User is signed in!');
  //   //   }
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
        future: _homePage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const SplashScreen();
          }
        },
      ),
      // home: AuthGate(),

      routes: {
        "loginScreen": (context) => LoginPage(
              onTap: () {},
            ),
        "registerScreen": (context) => RegisterPage(
              onTap: () {},
            ),
        //"homeScreen": (context) => HomePage(),
        //"burgerDetailsScreen": (context) => BurgerDetails(),
        "radioButton": (context) => MyRadioButton(),
        'ProductSelectionScreen': (context) => ProductSelectionScreen(),
        'AdminHomePage': (context) => AdminHomePage(),
        "LoginOrRegister": (context) => LoginOrRegister(),

        'chickenScreen': (context) => ChickenScreen(),
        'PizzaDetailsScreen': (context) => PizzaDetailsScreen(),
        'userScreen': (context) => UserHomePage(),
        // Foods
        "burgerScreen": (context) => BurgersScreen(),
        'pizzaScreen': (context) => PizzaScreen(),
        'fishScreen': (context) => FishScreen(),
        'meatScreen': (context) => MeatScreen(),
        'pastaScreen': (context) => PastaScreen(),
        'sushiScreen': (context) => SushiScreen(),
        // Drinks
        "coffee": (context) => Coffee(),
        'tea': (context) => Tea(),
        'pepsi': (context) => Pepsi(),
        'water': (context) => Water(),
        'lemonadeJuice': (context) => LemonadeJuice(),
        'strawberryJuice': (context) => StrawberryJuice(),
        'orangeJuice': (context) => OrangeJuice(),
        //Sweets
        'iceCream': (context) => IceCream(),
        'chocolateCake': (context) => ChocolateCake(),
        'donuts': (context) => Donuts(),
        'waffle': (context) => Waffle(),
        'cupcake': (context) => Cupcake(),
        // Popular Offers
        'burgerandfries1': (context) => BurgerFriesLast(),
        'burger and pepsi': (context) => BurgerAndPepsi(),
        'fishandrice': (context) => FishAndRice(),
        'meatandjuice': (context) => MeatAndJuice(),
        'chickenandrice': (context) => ChickenAndRice(),
        'pastaandChicken': (context) => PastaAndChicken(),
      },
    );
  }
}
