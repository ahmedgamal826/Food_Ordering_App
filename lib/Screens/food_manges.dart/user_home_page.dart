import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/Cubit/bottom%20navigator%20cubit/bottom_nav_cubit.dart';
import 'package:food_ordering_app/Cubit/bottom%20navigator%20cubit/bottom_nav_states.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/restaurant_home_page.dart';
import 'package:food_ordering_app/Screens/offers_screen.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

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

  @override
  Widget build(BuildContext context) {
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

                final pages = [
                  const RestaurantHomePage(),
                  const OffersScreen(),
                  OrderScreen(),
                  FavouriteScreen(),
                  const ProfileScreen(),
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
                      Icon(Icons.favorite, size: 30, color: Colors.white),
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
