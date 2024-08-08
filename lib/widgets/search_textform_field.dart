import 'package:flutter/material.dart';

class SearchTextformField extends StatelessWidget {
  SearchTextformField({super.key, required this.hintText});

  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            filled: true,
            fillColor: Colors.orange,
          ),
        ));
  }
}
