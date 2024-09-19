import 'package:flutter/material.dart';

class PriceAdminCategory extends StatelessWidget {
  PriceAdminCategory({
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
    return SizedBox(
      width: 60,
      child: collectionName == 'offers_category'
          ? Text(
              textAlign: TextAlign.center,
              '\$${priceBeforeDiscount}',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : Text(
              textAlign: TextAlign.center,
              '\$${price.toString()}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}
