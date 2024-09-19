import 'package:flutter/material.dart';

class PriceAfterDiscountAdmin extends StatelessWidget {
  PriceAfterDiscountAdmin({super.key, required this.price});

  double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Text(
        '\$${price}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
