import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // String searchQuery = '';
  bool isLoading = false;

  // void updateSearchQuery(String query) {
  //   setState(() {
  //     searchQuery = query;
  //   });
  // }

  Future<void> logout(BuildContext context) async {
    setState(() {
      isLoading = true; // عرض دائرة التحميل
    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOrUserScreen(),
      ),
    ).whenComplete(() {
      setState(() {
        isLoading = false; // إخفاء دائرة التحميل
      });
    });
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Welcome, Admin! 👋 ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'You can manage all foods, drinks and sweets items here. Use the options below to view, add, update or delete the restaurant categories.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            indent: 50,
            endIndent: 50,
          ),
          SizedBox(
            height: 30,
          ),
          CategoryListView(
            categoryName: 'Foods',
          ),
          SizedBox(
            height: 30,
          ),
          CategoryListView(
            categoryName: 'Drinks',
          ),
          SizedBox(
            height: 30,
          ),
          CategoryListView(
            categoryName: 'Sweets',
          ),
          SizedBox(
            height: 30,
          ),
          CategoryListView(
            categoryName: 'Popular Meals',
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
