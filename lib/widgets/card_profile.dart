import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardProfile extends StatelessWidget {
  CardProfile({
    super.key,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.title,
  });

  IconButton prefixIcon;
  String title;
  IconButton suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 5,
        color: Colors.orange,
        child: ListTile(
            leading: prefixIcon,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: suffixIcon),
      ),
    );
  }
}
