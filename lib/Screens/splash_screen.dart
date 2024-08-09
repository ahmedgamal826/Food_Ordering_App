import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/register.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/auth/login_screen.dart';
import 'package:food_ordering_app/Screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AdminOrUserScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}
