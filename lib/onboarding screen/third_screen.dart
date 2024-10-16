import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/on boadring 3.jpg"),
        const Text(
          "Share \nYour playlist",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 199, 59)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "Share the playlist you created and share it with friends and family",
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
