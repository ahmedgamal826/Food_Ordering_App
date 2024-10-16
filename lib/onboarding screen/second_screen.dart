import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/onboarding 2.jpg"),
        const Text(
          "Listen to \nmusic offline",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 199, 59)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Download the music you want and enjoy it whatever and whenever",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 54, 33)),
          ),
        ),
      ],
    );
  }
}
