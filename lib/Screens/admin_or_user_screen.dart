import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/admin_login_screen.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/register.dart';
import 'package:food_ordering_app/widgets/map_screen.dart';
import 'package:food_ordering_app/auth/login_or_register.dart';
import 'package:food_ordering_app/auth/login_page.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';

class AdminOrUserScreen extends StatelessWidget {
  const AdminOrUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Food Delivery App!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please select your role to proceed.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              buttonText: 'Admin',
              onPressed: () {
                Navigator.push(
                  context, // AdminLoginScreen
                  MaterialPageRoute(builder: (_) => AdminLoginScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'User',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginOrRegister()),
                  //MaterialPageRoute(builder: (_) => GetLocation()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
