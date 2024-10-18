import 'package:flutter/material.dart';

class SearchTextformField extends StatelessWidget {
  SearchTextformField(
      {super.key, required this.hintText, required this.onChanged});

  String hintText;
  final ValueChanged<String> onChanged; // Add this line

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: TextField(
          onChanged: onChanged,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            hintText: hintText,
            prefixIconColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.white),
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
