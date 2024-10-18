import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/bottom%20navigator%20cubit/bottom_nav_cubit.dart';
import 'package:food_ordering_app/Cubit/bottom%20navigator%20cubit/bottom_nav_states.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_profile_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_home_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/orders_managment.dart';
import 'package:food_ordering_app/Screens/offers_screen.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:provider/provider.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  int selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: pages[selectedIndex],
    //     // bottomNavigationBar: BottomNavigationBar(
    //     //   backgroundColor: Colors.black,
    //     //   items: const [
    //     //     BottomNavigationBarItem(
    //     //       backgroundColor: Colors.white,
    //     //       icon: Icon(
    //     //         Icons.home,
    //     //         size: 30,
    //     //       ),
    //     //       label: 'Admin Home',
    //     //     ),
    //     //     BottomNavigationBarItem(
    //     //       backgroundColor: Colors.white,
    //     //       icon: Icon(
    //     //         Icons.local_offer_sharp,
    //     //         size: 30,
    //     //       ),
    //     //       label: 'Offers',
    //     //     ),
    //     //     BottomNavigationBarItem(
    //     //       backgroundColor: Colors.white,
    //     //       icon: Icon(
    //     //         Icons.shopping_cart,
    //     //         size: 30,
    //     //       ),
    //     //       label: 'Order Management',
    //     //     ),
    //     //     BottomNavigationBarItem(
    //     //       backgroundColor: Colors.white,
    //     //       icon: Icon(
    //     //         Icons.account_circle,
    //     //         size: 30,
    //     //       ),
    //     //       label: 'Account Management',
    //     //     ),
    //     //     BottomNavigationBarItem(
    //     //       backgroundColor: Colors.white,
    //     //       icon: Icon(
    //     //         Icons.person,
    //     //         size: 30,
    //     //       ),
    //     //       label: 'Profile',
    //     //     ),
    //     //   ],
    //     //   currentIndex: _selectedIndex,
    //     //   selectedItemColor: Colors.orange,
    //     //   unselectedItemColor: Colors.grey,
    //     //   onTap: _onItemTapped,
    //     // ),

    //     bottomNavigationBar: CurvedNavigationBar(
    //       backgroundColor: Colors.transparent, // background for the navigation
    //       color: Colors.orange, // the color of the nav bar
    //       buttonBackgroundColor: Colors.orange, // the color of the active button
    //       animationDuration: const Duration(milliseconds: 300), // Animation speed
    //       height: 60,
    //       index: selectedIndex,
    //       items: const [
    //         Icon(Icons.home, size: 30, color: Colors.white),
    //         Icon(Icons.local_offer, size: 30, color: Colors.white),
    //         Icon(Icons.shopping_cart, size: 30, color: Colors.white),
    //         Icon(Icons.account_circle, size: 30, color: Colors.white),
    //         Icon(Icons.person, size: 30, color: Colors.white),
    //       ],

    //       onTap: (index) {
    //         context.read<BottomNavCubit>().selectIndex(index);
    //         animationController.forward(from: 0.0); // Trigger animation on tap
    //       },
    //     ),
    //   );
    // }

    final authService = Provider.of<UserAuthService>(context);
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: StreamBuilder<User?>(
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
                title: const Text(''),
              ),
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            if (!authService.isLoggedIn) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(''),
                ),
                body: const Center(
                  child: Text('User is not logged in'),
                ),
              );
            }

            return BlocBuilder<BottomNavCubit, BottomNavState>(
              builder: (context, state) {
                int selectedIndex = 0;

                if (state is BottomNavInitial) {
                  selectedIndex = state.selectedIndex;
                } else if (state is BottomNavUpdated) {
                  selectedIndex = state.selectedIndex;
                  animationController.forward(
                    from: 0.0,
                  ); // Trigger animation on index change
                }

                final List<Widget> pages = [
                  const AdminHomeScreen(),
                  const OffersScreen(),
                  OrdersManagment(),
                  AccountManagement(),
                  const AdminProfileScreen()
                ];

                return Scaffold(
                  body: pages[selectedIndex], // Display the selected page
                  bottomNavigationBar: CurvedNavigationBar(
                    backgroundColor:
                        Colors.transparent, // background for the navigation
                    color: Colors.orange, // the color of the nav bar
                    buttonBackgroundColor:
                        Colors.orange, // the color of the active button
                    animationDuration:
                        const Duration(milliseconds: 300), // Animation speed
                    height: 60,
                    index: selectedIndex,
                    items: const [
                      Icon(Icons.home, size: 30, color: Colors.white),
                      Icon(Icons.local_offer, size: 30, color: Colors.white),
                      Icon(Icons.shopping_cart, size: 30, color: Colors.white),
                      Icon(Icons.account_circle, size: 30, color: Colors.white),
                      Icon(Icons.person, size: 30, color: Colors.white),
                    ],

                    onTap: (index) {
                      context.read<BottomNavCubit>().selectIndex(index);
                      animationController.forward(
                          from: 0.0); // Trigger animation on tap
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
