import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/fries_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/meat_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/pasta_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/rice_screen.dart';
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
import 'package:food_ordering_app/Screens/food_manges.dart/admin_management.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/chicken_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/pizza_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';
import 'package:food_ordering_app/Screens/radio_button.dart';
import 'package:food_ordering_app/Screens/splash_screen.dart';
import 'package:food_ordering_app/auth/auth_services_admin.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/auth/login_or_register.dart';
import 'package:food_ordering_app/auth/login_page.dart';
import 'package:food_ordering_app/auth/register_page.dart';
import 'package:food_ordering_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (context) => AdminAuthService(),
      ),
    ],
    child: const FoodOrderingApp(),
  ));
}

class FoodOrderingApp extends StatefulWidget {
  const FoodOrderingApp({super.key});

  @override
  State<FoodOrderingApp> createState() => _FoodOrderingAppState();
}

class _FoodOrderingAppState extends State<FoodOrderingApp> {
  late Future<Widget> _homePage;

  @override
  void initState() {
    super.initState();
    _homePage = _getHomePage();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in: ${user.email}');
      }
    });
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
        return UserHomePage(); // User home page
      }
    }

    if (adminDoc.exists) {
      String role = adminDoc.get('rool');
      if (role == 'admin') {
        return AdminManagement(); // Admin home page
      }
    }

    return SplashScreen(); // Fallback page if no valid role is found
  }

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
      routes: {
        "loginScreen": (context) => LoginPage(
              onTap: () {},
            ),
        "registerScreen": (context) => RegisterPage(
              onTap: () {},
            ),
        "radioButton": (context) => MyRadioButton(),
        'AdminHomePage': (context) => const AdminManagement(),
        "LoginOrRegister": (context) => const LoginOrRegister(),
        'chickenScreen': (context) => const ChickenScreen(),
        // 'PizzaDetailsScreen': (context) => const PizzaDetailsScreen(),
        'userScreen': (context) => const UserHomePage(),
        // Foods
        "burgerScreen": (context) => const BurgersScreen(),
        "friesScreen": (context) => const FriesScreen(),
        'pizzaScreen': (context) => const PizzaScreen(),
        'fishScreen': (context) => const FishScreen(),
        'meatScreen': (context) => const MeatScreen(),
        'riceScreen': (context) => const RiceScreen(),
        'pastaScreen': (context) => const PastaScreen(),
        'sushiScreen': (context) => const SushiScreen(),
        // Drinks
        "coffee": (context) => const Coffee(),
        'tea': (context) => const Tea(),
        'pepsi': (context) => const Pepsi(),
        'water': (context) => const Water(),
        'lemonadeJuice': (context) => const LemonadeJuice(),
        'strawberryJuice': (context) => const StrawberryJuice(),
        'orangeJuice': (context) => const OrangeJuice(),
        // Sweets
        'iceCream': (context) => const IceCream(),
        'chocolateCake': (context) => const ChocolateCake(),
        'donuts': (context) => const Donuts(),
        'waffle': (context) => const Waffle(),
        'cupcake': (context) => const Cupcake(),
        // Popular Offers
        'burgerandfries1': (context) => const BurgerFriesLast(),
        'burger and pepsi': (context) => const BurgerAndPepsi(),
        'fishandrice': (context) => const FishAndRice(),
        'meatandjuice': (context) => const MeatAndJuice(),
        'chickenandrice': (context) => const ChickenAndRice(),
        'pastaandChicken': (context) => const PastaAndChicken(),
      },
    );
  }
}
