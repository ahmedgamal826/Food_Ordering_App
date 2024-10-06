import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/add_card_form.dart';
import 'package:food_ordering_app/widgets/card_list_item.dart';
import 'package:food_ordering_app/widgets/confirm_remove_card.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class MyPaymentCardsScreen extends StatefulWidget {
  const MyPaymentCardsScreen({super.key});

  @override
  State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
}

class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _addCard(String cardNumber, String expiryDate) async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      await _firestore.collection('myCards').add({
        'userId': userId,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
      });
    }
  }

  void _confirmRemoveCard(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmRemoveCard(
          title: 'Confirm Delete',
          content: 'Are you sure you want to delete this card?',
          onConfirm: () {
            _removeCard(docId);
            Navigator.of(context).pop(); // Close the dialog
            customShowSnackBar(
              context: context,
              content: 'Card Deleted Successfully',
            );
          },
          onCancel: () => Navigator.of(context).pop(), // Cancel action
        );
      },
    );
  }

  void _removeCard(String docId) async {
    await _firestore.collection('myCards').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final userId = _auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'My Payment Cards',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('myCards')
                    .where('userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }

                  final cards = snapshot.data?.docs ?? [];

                  if (cards.isEmpty) {
                    return const Center(
                      child: Text(
                        'No cards found',
                        style: TextStyle(
                          fontSize: 25,
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
                      final cardNumber = cardData['cardNumber'] ?? 'Unknown';
                      final expiryDate = cardData['expiryDate'] ?? 'Unknown';

                      return CardListItem(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        onDelete: () => _confirmRemoveCard(cards[index].id),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add New Card'),
                      content: AddCardForm(onAddCard: _addCard),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                'Add New Card',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
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
