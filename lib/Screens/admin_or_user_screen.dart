import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/admin_login_screen.dart';
import 'package:food_ordering_app/auth/login_or_register.dart';
import 'package:food_ordering_app/components/clip_path_widget.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';

class AdminOrUserScreen extends StatelessWidget {
  const AdminOrUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPathWidget(
              txt: 'Admin or User',
            ),
            const SizedBox(
              height: 50,
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonText: 'Admin',
                onPressed: () {
                  Navigator.push(
                    context, // AdminLoginScreen
                    MaterialPageRoute(builder: (_) => AdminLoginScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonText: 'User',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginOrRegister()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
