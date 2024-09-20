import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/user_home_page.dart';

class InvoiceDialog extends StatelessWidget {
  final String customerName;
  final List<dynamic> items;
  final double deliveryPrice;
  final double total;
  final String deliveryAddress;
  final Function addToCart; // Function to handle adding to cart
  final Function customShowSnackBar; // Function for showing snack bar

  const InvoiceDialog({
    Key? key,
    required this.customerName,
    required this.items,
    required this.deliveryPrice,
    required this.total,
    required this.deliveryAddress,
    required this.addToCart,
    required this.customShowSnackBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Invoice',
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            _buildRow('Customer Name: ', customerName),
            const SizedBox(height: 10),
            _buildRow('Card Type: ', 'Selected Card Name'), // Replace as needed
            const SizedBox(height: 10),
            _buildRow('Delivery Address: ', deliveryAddress),
            const SizedBox(height: 10),
            _buildRow(
                'Delivery Price: ', '\$${deliveryPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            const Text(
              'Products:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            ..._buildProductList(),
            const Divider(
              indent: 25,
              endIndent: 25,
              color: Colors.orange,
              thickness: 3,
            ),
            ListTile(
              leading: const Text(
                'Total: ',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () async {
            final userId = FirebaseAuth.instance.currentUser?.uid;

            if (userId == null) {
              customShowSnackBar(
                context: context,
                content: "User is not logged in.",
              );
              return;
            }

            // Pass the data to the function
            await addToCart(
              customerName: customerName,
              deliveryAddress: deliveryAddress,
              total: total,
              deliveryPrice: deliveryPrice,
              itemsCarts: items,
            );

            final cartRef =
                FirebaseFirestore.instance.collection('carts').doc(userId);
            final cartSnapshot = await cartRef.get();

            if (cartSnapshot.exists) {
              await cartRef.update({'items': []});
            } else {
              customShowSnackBar(
                context: context,
                content: "Cart not found.",
              );
            }

            // Navigate to UserHomePage and remove all previous pages from the navigation stack
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomePage(),
              ),
              (route) => false, // Remove all previous routes
            );

            customShowSnackBar(
              context: context,
              content: 'The Purchase Completed Successfully.',
            );
          },
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.orange,
          ),
        ),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              value,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildProductList() {
    return items.map((item) {
      final product = item['product'] as Map<String, dynamic>? ?? {};
      final productName = product['name'] as String? ?? '';
      final quantity = item['quantity'] as int? ?? 0;
      final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

      return ListTile(
        leading: Text(
          '$quantity',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        title: Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          productName,
        ),
        trailing: Text(
          '\$${itemTotalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }).toList();
  }
}
