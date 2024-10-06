import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_management.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';
import 'package:food_ordering_app/Screens/splash_screen.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen(
      {super.key, required this.role}); // Adding the role property

  final String role; // Define the role property

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  double ballY = 0;
  double widthVal = 100;
  double heightVal = 50;
  double bottomVal = 500;
  bool add = false;
  bool showShadow = false;
  int times = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        // Animation logic
        if (add) {
          ballY += 15;
        } else {
          ballY -= 15;
        }
        if (ballY <= -200) {
          times += 1;
          add = true;
          showShadow = true;
        }
        if (ballY >= 0) {
          add = false;
          showShadow = false;
          widthVal += 50;
          heightVal += 50;
          bottomVal -= 200;
        }
        if (times == 3) {
          showShadow = false;
          widthVal = MediaQuery.of(context).size.width;
          heightVal = MediaQuery.of(context).size.height;

          Timer(const Duration(milliseconds: 250), () {
            // Navigate to the appropriate home page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if (widget.role == 'admin') {
                    return const AdminManagement();
                  } else if (widget.role == 'user') {
                    return const UserHomePage();
                  } else {
                    return SplashScreen();
                  }
                },
              ),
              (Route<dynamic> route) => false,
            );
          });
          _controller.stop();
        }
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              bottom: bottomVal,
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  Transform.translate(
                    offset: Offset(0, ballY),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: times == 3 ? 5 : 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: widthVal,
                        height: heightVal,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  if (showShadow)
                    Container(
                      width: 50,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
