import 'package:flutter/material.dart';

class OrderCardInProfile extends StatelessWidget {
  final String formattedTime;
  final List<dynamic> items;

  const OrderCardInProfile({
    Key? key,
    required this.formattedTime,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Order Time: $formattedTime',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...items.map((item) {
            final product = (item['product'] as Map<String, dynamic>?) ?? {};
            final productName = product['name'] as String? ?? '';
            final quantity = item['quantity'] as int? ?? 0;
            final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

            return Card(
              color: Colors.orange,
              margin: const EdgeInsets.all(8.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${itemTotalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
