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
      cursorColor: Colors.white,
      keyboardType: hinText == 'Food Name' ||
              hinText == 'Drink Name' ||
              hinText == 'Sweet Name' ||
              hinText == 'Offer Name' ||
              hinText == 'Food Description' ||
              hinText == 'Drink Description' ||
              hinText == 'Sweet Description' ||
              hinText == 'Offer Description'
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
