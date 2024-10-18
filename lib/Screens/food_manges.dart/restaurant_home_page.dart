import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/restaurant_list_view.dart';

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: const Text(''),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!authService.isLoggedIn) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: const Center(child: Text('User is not logged in')),
          );
        }

        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          return const Center(child: Text('No user found.'));
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_app')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            var userData = snapshot.data?.data() as Map<String, dynamic>?;
            String? profileImageUrl = userData?['profileImage'];

            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: BlocProvider(
                        create: (context) => LocationCubit()..getLocation(),
                        child: RestaurantListView(
                          authService: authService,
                          deliveryAddress: '',
                          profileImageUrl: profileImageUrl as String? ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
