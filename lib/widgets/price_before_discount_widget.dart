import 'package:flutter/material.dart';

class PriceBeforeDiscountWidget extends StatelessWidget {
  PriceBeforeDiscountWidget({
    super.key,
    required this.collectionName,
    required this.priceBeforeDiscount,
    required this.price,
  });

  final String collectionName;
  double priceBeforeDiscount;
  double price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 50),
        child: collectionName == 'offers_category'
            ? Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '\$$priceBeforeDiscount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                  overflow:
                      TextOverflow.ellipsis, // Ensure text doesn't overflow
                  // maxLines: 2,
                ),
              )
            : Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                // maxLines: 2,
              ),
      ),
    );
  }
}
