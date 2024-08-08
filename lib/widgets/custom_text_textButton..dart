import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTextAndTextbutton extends StatelessWidget {
  CustomTextAndTextbutton(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onTap});

  String text1;
  String text2;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: text1,
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
            TextSpan(
                text: text2,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ]),
        )
      ],
    );
  }
}
