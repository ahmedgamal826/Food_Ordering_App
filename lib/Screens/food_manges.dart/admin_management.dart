// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
// import 'package:food_ordering_app/widgets/category_list_view.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
// import 'package:food_ordering_app/widgets/search_textform_field.dart';

// import '../Test Screens/admin_login_screen.dart';

// class AdminManagement extends StatefulWidget {
//   const AdminManagement({super.key});

//   @override
//   State<AdminManagement> createState() => _AdminManagementState();
// }

// class _AdminManagementState extends State<AdminManagement> {
//   String searchQuery = '';
//   bool isLoading = false;

//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//     });
//   }

//   // Future<void> logout(BuildContext context) async {
//   //   CircularProgressIndicator(
//   //     color: Colors.orange,
//   //   );
//   //   await FirebaseAuth.instance.signOut();
//   //   Navigator.pushReplacement(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => AdminOrUserScreen(),
//   //     ),
//   //   );
//   // }

//   Future<void> logout(BuildContext context) async {
//     setState(() {
//       isLoading = true; // عرض دائرة التحميل
//     });

//     await FirebaseAuth.instance.signOut();

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AdminOrUserScreen(),
//       ),
//     ).whenComplete(() {
//       setState(() {
//         isLoading = false; // إخفاء دائرة التحميل
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         centerTitle: true,
//         title: const Text(
//           "Admin - Manage Foods",
//           style: TextStyle(
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               logout(context);
//             },
//             icon: const Icon(
//               Icons.logout,
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: const [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Text(
//               'Welcome Admin ',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           CategoryListView(),
//           SizedBox(
//             height: 30,
//           ),
//           CategoryListView(),
//           SizedBox(
//             height: 30,
//           ),
//           CategoryListView(),
//           SizedBox(
//             height: 30,
//           ),
//           CategoryListView(),
//           SizedBox(
//             height: 30,
//           ),
//           CategoryListView()
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_home_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/order_managment.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement> {
  int _selectedIndex = 0; // Track the selected index

  final List<Widget> _pages = [
    AdminHomeScreen(),
    OrderManagment(),
    // List of all orders with details such as customer name, ordered items, order status, and timestamps.
    //Ability to update the status of orders (e.g., pending, in progress, completed, canceled).

    AccountManagement(),
    // Information on user accounts, including their order history and payment details.
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Admin Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            label: 'Order Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 30,
            ),
            label: 'Account Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
