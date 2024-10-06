import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int? selectedCard;

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showCheckoutBottomSheet(context, userId);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext context, String? userId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffF4F4F4),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Payment Method',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('myCards')
                          .where('userId', isEqualTo: userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final cards = snapshot.data?.docs ?? [];

                        if (cards.isEmpty) {
                          return const Center(
                            child: Text(
                              'No cards found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final cardData =
                                cards[index].data() as Map<String, dynamic>;
                            final cardNumber =
                                cardData['cardNumber'] ?? 'Unknown';
                            final expiryDate =
                                cardData['expiryDate'] ?? 'Unknown';

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCard = index;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: ListTile(
                                    leading: Image.asset(
                                      'assets/images/master_card.png',
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: const Text(
                                      'Credit card',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _formatCardNumber(cardNumber),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    trailing: Radio<int>(
                                      value: index,
                                      groupValue: selectedCard,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedCard = value;
                                        });
                                      },
                                      activeColor: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the BottomSheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String _formatCardNumber(String cardNumber) {
    final buffer = StringBuffer();
    for (int i = 0; i < cardNumber.length; i++) {
      buffer.write(cardNumber[i]);
      if ((i + 1) % 4 == 0 && i != cardNumber.length - 1) {
        buffer.write(' '); // Add space every 4 digits
      }
    }
    return buffer.toString();
  }
}
