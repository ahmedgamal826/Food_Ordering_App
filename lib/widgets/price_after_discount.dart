import 'package:flutter/material.dart';

class PriceAfterDiscount extends StatelessWidget {
  PriceAfterDiscount({super.key, required this.price});

  double price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            overflow: TextOverflow.ellipsis,
            // maxLines: 2,
          ),
        ),
      ),
    );
  }
}
