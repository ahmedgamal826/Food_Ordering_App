import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/components/action_buttons_onboarding.dart';
import 'package:food_ordering_app/components/build_description_setion.dart';
import 'package:food_ordering_app/components/build_image_section.dart';
import 'package:food_ordering_app/components/build_title_section.dart';
import 'package:food_ordering_app/components/custom_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;
  bool isOut = false;

  List<String> images = [
    'assets/images/onboarding 1.jpg',
    'assets/images/onboarding 2.jpg',
    'assets/images/onboadring 3.jpg',
  ];

  List<String> titles = [
    'Let’s Discover Your Favorite Flavor!',
    'Speedy Deliveries at Your Service!',
    'Delicious Delights Just Delivered!',
  ];

  List<String> descriptions = [
    "With so many choices, making the right decision can be tough! Do you prefer pizza, burgers, or maybe sushi? Let us help you find what suits your taste!",
    "Ready to deliver orders in a flash! With every minute counting, we're here to provide the best delivery service right to your door. Let us take you to your favorite destination!",
    "A variety of delicious foods! From burgers to sushi and drinks, everything to satisfy your cravings in one meal. Enjoy a rich culinary experience!",
  ];

  void _nextPage() {
    setState(() {
      isOut = !isOut;
    });
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        isOut = !isOut;
        if (index == 2) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminOrUserScreen(),
            ),
            (route) => false,
          );
        }
        index = index > 1 ? 2 : index + 1;
      });
    });
  }

  void _backPage() {
    setState(() {
      if (index > 0) {
        isOut = !isOut;
        Timer(const Duration(milliseconds: 300), () {
          setState(() {
            isOut = !isOut;
            index--;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ImageSection(
              image: images[index],
              isOut: isOut,
            ),
            TitleSection(
              title: titles[index],
              isOut: isOut,
            ),
            DescriptionSection(
              description: descriptions[index],
              isOut: isOut,
            ),
            buildIndicators(),
            ActionButtons(
              index: index,
              isOut: isOut,
              onNext: _nextPage,
              onBack: _backPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIndicator(active: index == 0),
        const SizedBox(width: 8),
        CustomIndicator(active: index == 1),
        const SizedBox(width: 8),
        CustomIndicator(active: index == 2),
      ],
    );
  }
}
