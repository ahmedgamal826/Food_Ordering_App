import 'package:flutter/material.dart';

class RestaurantIntroWidget extends StatelessWidget {
  const RestaurantIntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Let's enjoy",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'tasty meals, drinks, and desserts!',
            style: TextStyle(fontSize: 23),
          ),
        ),
      ],
    );
  }
}
