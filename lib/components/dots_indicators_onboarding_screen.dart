import 'package:flutter/material.dart';

class DotsIndicatorOnboardingScreens extends StatelessWidget {
  const DotsIndicatorOnboardingScreens({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          width: _currentIndex == index ? 30 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.orange : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
