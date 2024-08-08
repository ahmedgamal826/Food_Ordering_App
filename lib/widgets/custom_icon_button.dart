import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({super.key, required this.image, required this.onTap});

  String image;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
