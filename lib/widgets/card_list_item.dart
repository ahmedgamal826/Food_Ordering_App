// import 'package:flutter/material.dart';

// class CardListItem extends StatelessWidget {
//   final String cardImage;
//   final String cardNumber;
//   final String expiryDate;
//   final VoidCallback onDelete;

//   const CardListItem({
//     Key? key,
//     required this.cardImage,
//     required this.cardNumber,
//     required this.expiryDate,
//     required this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.orange,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Image.asset('assets/images/master_card.png'),
//         contentPadding: const EdgeInsets.all(16.0),
//         title: Text(
//           formatCardNumber(cardNumber),
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         subtitle: Text(
//           'Expires: $expiryDate',
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }
// }

// String formatCardNumber(String cardNumber) {
//   final buffer = StringBuffer();
//   for (int i = 0; i < cardNumber.length; i++) {
//     buffer.write(cardNumber[i]);
//     if ((i + 1) % 4 == 0 && i != cardNumber.length - 1) {
//       buffer.write(' '); // Add space every 4 digits
//     }
//   }
//   return buffer.toString();
// }

import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final String cardImage;
  final String cardNumber;
  final String expiryDate;
  final VoidCallback onDelete;

  const CardListItem({
    Key? key,
    required this.cardImage,
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
        leading: Image.asset(
          cardImage,
          width: 90,
          fit: BoxFit.cover,
        ),
        contentPadding: const EdgeInsets.all(16.0),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            formatCardNumber(cardNumber),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Text(
          'Expiry: $expiryDate',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 28,
          ),
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
      buffer.write(' '); // إضافة مسافة كل 4 أرقام
    }
  }
  return buffer.toString();
}
