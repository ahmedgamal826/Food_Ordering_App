import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/constants_variables.dart';

class ImageSection extends StatelessWidget {
  final String image;
  final bool isOut;

  const ImageSection({
    super.key,
    required this.image,
    required this.isOut,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      height: height(context) * 0.5,
      child: AnimatedScale(
        scale: isOut ? 0 : 1,
        duration: const Duration(milliseconds: 250),
        child: Image.asset(image),
      ),
    );
  }
}
