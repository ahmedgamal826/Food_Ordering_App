import 'package:flutter/material.dart';

class CustomOrText extends StatelessWidget {
  CustomOrText({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
