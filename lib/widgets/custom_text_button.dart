import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({super.key, required this.onPressed, required this.text});

  void Function()? onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forget Password?',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
