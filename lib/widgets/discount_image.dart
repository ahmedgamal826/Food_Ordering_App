import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/constants_variables.dart';

class DiscountedImage extends StatelessWidget {
  final String imageUrl;
  final String discountOffer;

  const DiscountedImage({
    Key? key,
    required this.imageUrl,
    required this.discountOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height(context) * 0.18,
          width: double.infinity,
          child: imageUrl.startsWith('http')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    // fit: BoxFit.cover,
                    imageUrl,
                  ),
                )
              : const Center(
                  child: Icon(
                    Icons.image,
                    size: 120,
                    color: Colors.black,
                  ),
                ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: 60,
            color: Colors.red,
            child: Text(
              textAlign: TextAlign.center,
              '${discountOffer}% OFF',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
