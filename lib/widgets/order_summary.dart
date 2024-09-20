import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/dismissble_product_card.dart';
import 'checkout_button.dart';

class OrderSummary extends StatelessWidget {
  final List<dynamic> items;
  final double deliveryPrice;
  final double totalPrice;
  final Future<void> Function(String itemId, String productName) deleteItem;
  final Future<void> Function(String itemId, int quantity, String size)
      updateItem;
  final String customerName;

  const OrderSummary({
    Key? key,
    required this.items,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.deleteItem,
    required this.updateItem,
    required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            'Your Order',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map<String, dynamic>;
              final product = item['product'] as Map<String, dynamic>? ?? {};

              final itemId = item['id'] as String? ?? '';
              final productName = product['name'] as String? ?? '';
              final productImage = product['image'] as String? ?? '';
              int quantity = item['quantity'] as int? ?? 0;
              final size = item['size'] as String? ?? '';
              final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

              return DismissibleProductCard(
                deleteItem: deleteItem,
                itemId: itemId,
                productName: productName,
                itemTotalPrice: itemTotalPrice,
                productImage: productImage,
                quantity: quantity,
                size: size,
                updateItem: updateItem,
              );
            },
          ),
        ),
        const Divider(
          color: Colors.black,
          indent: 20,
          endIndent: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Delivery services:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${deliveryPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Total : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CheckoutButton(
                items: items,
                deliveryPrice: deliveryPrice,
                total: totalPrice,
                customerName: customerName,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
