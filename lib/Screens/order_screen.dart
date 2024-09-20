import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/order_summary.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final StreamController<void> _updateController = StreamController<void>();

  @override
  void dispose() {
    _updateController.close();
    super.dispose();
  }

  Future<void> deleteItem(String itemId, String productName) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final cartRef =
          FirebaseFirestore.instance.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();
      final cartData = cartSnapshot.data() as Map<String, dynamic>?;

      if (cartData != null) {
        final List<dynamic> items = cartData['items'] ?? [];
        items.removeWhere((item) => item['id'] == itemId);
        // items.removeWhere((item) => item['product']['name'] == productName);

        await cartRef.update({'items': items});
        customShowSnackBar(
          context: context,
          content: "$productName is deleted from cart",
        );
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> updateItem(
    String itemId,
    int quantity,
    String size,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final cartRef =
          FirebaseFirestore.instance.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();
      final cartData = cartSnapshot.data() as Map<String, dynamic>?;

      if (cartData != null) {
        final List<dynamic> items = cartData['items'] ?? [];
        final itemIndex = items.indexWhere((item) => item['id'] == itemId);

        if (itemIndex != -1) {
          double basePrice =
              (items[itemIndex]['product']['price'] as double?) ?? 0.0;

          // تحديد السعر بناءً على الحجم
          double sizeMultiplier;
          switch (size) {
            case 'Medium':
              sizeMultiplier = 1.5; // افتراض أن الحجم المتوسط يزيد 50%
              break;
            case 'Large':
              sizeMultiplier = 2.0; // افتراض أن الحجم الكبير يزيد 100%
              break;
            default:
              sizeMultiplier = 1.0; // الحجم الصغير بدون زيادة
          }

          double totalPrice = basePrice * sizeMultiplier * quantity;
          items[itemIndex]['quantity'] = quantity;
          items[itemIndex]['size'] = size;
          items[itemIndex]['totalPrice'] = totalPrice;

          await cartRef.update({'items': items});
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text("Item updated")),
          // );
        }
      }
    } catch (e) {
      print('Error updating item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deliveryPrice = 20;

    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Check if user is logged in
          if (!authService.isLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text(''),
              ),
              body: const Center(
                child: Text('User is not logged in'),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xffF4F4F4),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'userScreen');
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.orange,
                ),
              ),
              backgroundColor: const Color(0xffF4F4F4),
              centerTitle: true,
              title: const Text(
                'Check Out',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('carts')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text(
                      'No items in cart.',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final cartData = snapshot.data!.data() as Map<String, dynamic>;
                final items = cartData['items'] as List<dynamic>? ?? [];

                double totalPrice = 0;
                for (var item in items) {
                  final double itemPrice = item['totalPrice'] as double? ?? 0.0;
                  totalPrice += itemPrice;
                }

                // Add delivery price to total price
                if (totalPrice > 0) {
                  totalPrice += deliveryPrice;
                }

                return items.isEmpty
                    ? const Center(
                        child: Text(
                          'No items in cart.',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : OrderSummary(
                        deleteItem: deleteItem,
                        deliveryPrice: deliveryPrice,
                        items: items,
                        totalPrice: totalPrice,
                        updateItem: updateItem,
                        customerName: authService.userName ?? 'UnKnown',
                      );
              },
            ),
          );
        }
      },
    );
  }
}
