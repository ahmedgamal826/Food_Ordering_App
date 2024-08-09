import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/admin_login_screen.dart';
import 'package:food_ordering_app/auth/login_screen.dart';
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
            Text(
              'Welcome to the Food Ordering App!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Please select your role to proceed.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              buttonText: 'Admin',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdminLoginScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              buttonText: 'User',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
