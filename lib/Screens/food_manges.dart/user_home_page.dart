import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/home_page.dart';
import 'package:food_ordering_app/Screens/offers_screen.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/auth/auth_services.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0; // Track the selected index

  final List<Widget> _pages = [
    RestaurantHomePage(),
    OffersScreen(),
    OrderScreen(),
    FavouriteScreen(),
    const ProfileScreen(),
  ];

  bool isLoading = false;

  Future<void> logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOrUserScreen(),
      ),
    ).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          if (!authService.isLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text(''),
              ),
              body: const Center(
                child: Text('User is not logged in'),
              ),
            );
          }

          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.orange,
            //   centerTitle: true,
            //   title: const Text(
            //     'User Home Page',
            //     style: TextStyle(
            //       fontSize: 23,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //     ),
            //   ),
            //   actions: [
            //     IconButton(
            //       onPressed: () {
            //         logout(context);
            //       },
            //       icon: const Icon(
            //         Icons.logout,
            //       ),
            //     )
            //   ],
            // ),
            body: _pages[_selectedIndex], // Display the selected page
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.orange,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_offer,
                    size: 30,
                  ),
                  label: 'Offers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  label: 'Favourites',
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
      },
    );
  }
}
