import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_profile_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_home_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/orders_managment.dart';
import 'package:food_ordering_app/Screens/offers_screen.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AdminHomeScreen(),
    const OffersScreen(),
    OrdersManagment(),
    AccountManagement(),
    const AdminProfileScreen()
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
              Icons.local_offer_sharp,
              size: 30,
            ),
            label: 'Offers',
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
