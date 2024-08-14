import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

import '../Test Screens/admin_login_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator(
      color: Colors.orange,
    );
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOrUserScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          "Admin - Manage Foods",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      // body: FoodList(),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.orange,
      //     child: const Icon(
      //       Icons.add,
      //       size: 33,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => AddFoodPage(),
      //         ),
      //       );
      //     }),
      body: ListView(
        children: [
          SearchTextformField(
            hintText: 'Search your food...',
          ),
          const CategoryListView(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
