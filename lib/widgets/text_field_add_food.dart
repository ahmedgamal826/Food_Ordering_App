import 'package:flutter/material.dart';

class TextFieledAddFood extends StatelessWidget {
  TextFieledAddFood(
      {super.key, required this.controller, required this.hinText});

  TextEditingController controller;
  String hinText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: hinText == 'Food Name' ||
              hinText == 'Drink Name' ||
              hinText == 'Sweet Name'
          ? TextInputType.name
          : TextInputType.number,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.orange,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
