import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/admin_profile_screen.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool isLoading = false;

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
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Text(''),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          "Admin - Manage Restaurant",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingDots(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading profile image."),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String? profileImageUrl = data['profileImage'];

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          'Welcome, Admin! 👋 ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl)
                              : null,
                          child: profileImageUrl == null
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.orange,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'You can manage all foods, drinks and sweets items here. Use the options below to view, add, update or delete the restaurant categories.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(indent: 50, endIndent: 50),
                const SizedBox(height: 30),
                const CategoryListView(categoryName: 'Foods'),
                const SizedBox(height: 30),
                const CategoryListView(categoryName: 'Drinks'),
                const SizedBox(height: 30),
                const CategoryListView(categoryName: 'Sweets'),
                const SizedBox(height: 30),
                const CategoryListView(categoryName: 'Popular Meals'),
                const SizedBox(height: 20),
              ],
            );
          }

          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
