import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final VoidCallback onDelete;

  const CardListItem({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          formatCardNumber(cardNumber),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Expires: $expiryDate',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

String formatCardNumber(String cardNumber) {
  final buffer = StringBuffer();
  for (int i = 0; i < cardNumber.length; i++) {
    buffer.write(cardNumber[i]);
    if ((i + 1) % 4 == 0 && i != cardNumber.length - 1) {
      buffer.write(' '); // Add space every 4 digits
    }
  }
  return buffer.toString();
}
