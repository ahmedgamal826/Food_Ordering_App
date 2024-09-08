// // // // // import 'package:flutter/material.dart';

// // // // // class MyPaymentCardsScreen extends StatefulWidget {
// // // // //   const MyPaymentCardsScreen({super.key});

// // // // //   @override
// // // // //   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// // // // // }

// // // // // class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
// // // // //   List<Map<String, String>> cards = [
// // // // //     {'cardNumber': '**** **** **** 1234', 'expiryDate': '12/24'},
// // // // //     {'cardNumber': '**** **** **** 5678', 'expiryDate': '05/25'},
// // // // //   ];

// // // // //   void _addCard() {
// // // // //     // Functionality to add a new card
// // // // //     // You might use a form to input card details and add it to the list
// // // // //     print('Add new card');
// // // // //   }

// // // // //   void _removeCard(int index) {
// // // // //     setState(() {
// // // // //       cards.removeAt(index);
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: Colors.orange,
// // // // //         centerTitle: true,
// // // // //         title: const Text(
// // // // //           'My Payment Cards',
// // // // //           style: TextStyle(
// // // // //             fontSize: 25,
// // // // //             fontWeight: FontWeight.bold,
// // // // //             color: Colors.white,
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             // List of cards
// // // // //             Expanded(
// // // // //               child: ListView.builder(
// // // // //                 itemCount: cards.length,
// // // // //                 itemBuilder: (context, index) {
// // // // //                   final card = cards[index];
// // // // //                   return Card(
// // // // //                     margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //                     child: ListTile(
// // // // //                       contentPadding: const EdgeInsets.all(16.0),
// // // // //                       title: Text(
// // // // //                         card['cardNumber']!,
// // // // //                         style: TextStyle(
// // // // //                             fontSize: 16, fontWeight: FontWeight.bold),
// // // // //                       ),
// // // // //                       subtitle: Text(
// // // // //                         'Expires: ${card['expiryDate']}',
// // // // //                         style: TextStyle(fontSize: 14),
// // // // //                       ),
// // // // //                       trailing: IconButton(
// // // // //                         icon: const Icon(Icons.delete, color: Colors.red),
// // // // //                         onPressed: () => _removeCard(index),
// // // // //                       ),
// // // // //                     ),
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //             // Add new card button
// // // // //             ElevatedButton(
// // // // //               onPressed: _addCard,
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 backgroundColor: Colors.orange,
// // // // //               ),
// // // // //               child: const Text('Add New Card'),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';

// // // // class MyPaymentCardsScreen extends StatefulWidget {
// // // //   const MyPaymentCardsScreen({super.key});

// // // //   @override
// // // //   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// // // // }

// // // // class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
// // // //   List<Map<String, String>> cards = [
// // // //     {'cardNumber': '**** **** **** 1234', 'expiryDate': '12/24'},
// // // //     {'cardNumber': '**** **** **** 5678', 'expiryDate': '05/25'},
// // // //   ];

// // // //   void _addCard() {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) {
// // // //         return AlertDialog(
// // // //           title: const Text('Add New Card'),
// // // //           content: AddCardForm(
// // // //             onAddCard: (cardNumber, expiryDate) {
// // // //               setState(() {
// // // //                 cards.add({
// // // //                   'cardNumber': cardNumber,
// // // //                   'expiryDate': expiryDate,
// // // //                 });
// // // //               });
// // // //               Navigator.of(context).pop();
// // // //             },
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _removeCard(int index) {
// // // //     setState(() {
// // // //       cards.removeAt(index);
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         iconTheme: const IconThemeData(
// // // //           color: Colors.white,
// // // //         ),
// // // //         backgroundColor: Colors.orange,
// // // //         centerTitle: true,
// // // //         title: const Text(
// // // //           'My Payment Cards',
// // // //           style: TextStyle(
// // // //             fontSize: 25,
// // // //             fontWeight: FontWeight.bold,
// // // //             color: Colors.white,
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           children: [
// // // //             Expanded(
// // // //               child: ListView.builder(
// // // //                 physics: const BouncingScrollPhysics(),
// // // //                 itemCount: cards.length,
// // // //                 itemBuilder: (context, index) {
// // // //                   final card = cards[index];
// // // //                   return Card(
// // // //                     color: Colors.orange,
// // // //                     margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // //                     child: ListTile(
// // // //                       contentPadding: const EdgeInsets.all(16.0),
// // // //                       title: Text(
// // // //                         card['cardNumber']!,
// // // //                         style: const TextStyle(
// // // //                             fontSize: 16, fontWeight: FontWeight.bold),
// // // //                       ),
// // // //                       subtitle: Text(
// // // //                         'Expires: ${card['expiryDate']}',
// // // //                         style: TextStyle(fontSize: 14),
// // // //                       ),
// // // //                       trailing: IconButton(
// // // //                         icon: const Icon(Icons.delete, color: Colors.red),
// // // //                         onPressed: () => _removeCard(index),
// // // //                       ),
// // // //                     ),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //             ElevatedButton(
// // // //               onPressed: _addCard,
// // // //               style: ElevatedButton.styleFrom(
// // // //                 backgroundColor: Colors.orange,
// // // //               ),
// // // //               child: const Text(
// // // //                 'Add New Card',
// // // //                 style: TextStyle(
// // // //                   fontSize: 20,
// // // //                   color: Colors.white,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class AddCardForm extends StatefulWidget {
// // // //   final void Function(String cardNumber, String expiryDate) onAddCard;

// // // //   const AddCardForm({super.key, required this.onAddCard});

// // // //   @override
// // // //   State<AddCardForm> createState() => _AddCardFormState();
// // // // }

// // // // class _AddCardFormState extends State<AddCardForm> {
// // // //   final _cardNumberController = TextEditingController();
// // // //   final _expiryDateController = TextEditingController();
// // // //   final _formKey = GlobalKey<FormState>();

// // // //   void _submit() {
// // // //     if (_formKey.currentState?.validate() ?? false) {
// // // //       final cardNumber = _cardNumberController.text;
// // // //       final expiryDate = _expiryDateController.text;

// // // //       widget.onAddCard(cardNumber, expiryDate);
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Form(
// // // //       key: _formKey,
// // // //       child: Column(
// // // //         mainAxisSize: MainAxisSize.min,
// // // //         children: [
// // // //           TextFormField(
// // // //             controller: _cardNumberController,
// // // //             decoration: const InputDecoration(labelText: 'Card Number'),
// // // //             keyboardType: TextInputType.number,
// // // //             validator: (value) {
// // // //               if (value == null || value.isEmpty) {
// // // //                 return 'Please enter card number';
// // // //               }
// // // //               return null;
// // // //             },
// // // //           ),
// // // //           TextFormField(
// // // //             controller: _expiryDateController,
// // // //             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
// // // //             keyboardType: TextInputType.number,
// // // //             validator: (value) {
// // // //               if (value == null || value.isEmpty) {
// // // //                 return 'Please enter expiry date';
// // // //               }
// // // //               return null;
// // // //             },
// // // //           ),
// // // //           const SizedBox(height: 20),
// // // //           ElevatedButton(
// // // //             onPressed: _submit,
// // // //             style: ElevatedButton.styleFrom(
// // // //               backgroundColor: Colors.orange,
// // // //             ),
// // // //             child: const Text(
// // // //               'Add Card',
// // // //               style: TextStyle(
// // // //                 fontSize: 20,
// // // //                 color: Colors.white,
// // // //                 fontWeight: FontWeight.bold,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';

// // // class MyPaymentCardsScreen extends StatefulWidget {
// // //   const MyPaymentCardsScreen({super.key});

// // //   @override
// // //   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// // // }

// // // class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;

// // //   void _addCard(String cardNumber, String expiryDate) async {
// // //     final userId = _auth.currentUser?.uid;

// // //     if (userId != null) {
// // //       await _firestore.collection('myCards').add({
// // //         'userId': userId,
// // //         'cardNumber': cardNumber,
// // //         'expiryDate': expiryDate,
// // //       });
// // //     }
// // //   }

// // //   void _removeCard(String docId) async {
// // //     await _firestore.collection('myCards').doc(docId).delete();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final userId = _auth.currentUser?.uid;

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         iconTheme: const IconThemeData(
// // //           color: Colors.white,
// // //         ),
// // //         backgroundColor: Colors.orange,
// // //         centerTitle: true,
// // //         title: const Text(
// // //           'My Payment Cards',
// // //           style: TextStyle(
// // //             fontSize: 25,
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.white,
// // //           ),
// // //         ),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             Expanded(
// // //               child: StreamBuilder<QuerySnapshot>(
// // //                 stream: _firestore
// // //                     .collection('myCards')
// // //                     .where('userId', isEqualTo: userId)
// // //                     .snapshots(),
// // //                 builder: (context, snapshot) {
// // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // //                     return const Center(child: CircularProgressIndicator());
// // //                   }

// // //                   final cards = snapshot.data?.docs ?? [];

// // //                   if (cards.isEmpty) {
// // //                     return const Center(
// // //                       child: Text(
// // //                         'No cards found',
// // //                         style: TextStyle(
// // //                           fontSize: 18,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                     );
// // //                   }

// // //                   return ListView.builder(
// // //                     physics: const BouncingScrollPhysics(),
// // //                     itemCount: cards.length,
// // //                     itemBuilder: (context, index) {
// // //                       final cardData =
// // //                           cards[index].data() as Map<String, dynamic>;
// // //                       final cardNumber = cardData['cardNumber'] ?? 'Unknown';
// // //                       final expiryDate = cardData['expiryDate'] ?? 'Unknown';

// // //                       return Card(
// // //                         color: Colors.orange,
// // //                         margin: const EdgeInsets.symmetric(vertical: 8.0),
// // //                         child: ListTile(
// // //                           contentPadding: const EdgeInsets.all(16.0),
// // //                           title: Text(
// // //                             cardNumber,
// // //                             style: const TextStyle(
// // //                                 fontSize: 16, fontWeight: FontWeight.bold),
// // //                           ),
// // //                           subtitle: Text(
// // //                             'Expires: $expiryDate',
// // //                             style: const TextStyle(fontSize: 14),
// // //                           ),
// // //                           trailing: IconButton(
// // //                             icon: const Icon(Icons.delete, color: Colors.red),
// // //                             onPressed: () => _removeCard(cards[index].id),
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 showDialog(
// // //                   context: context,
// // //                   builder: (context) {
// // //                     return AlertDialog(
// // //                       title: const Text('Add New Card'),
// // //                       content: AddCardForm(onAddCard: _addCard),
// // //                     );
// // //                   },
// // //                 );
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: Colors.orange,
// // //               ),
// // //               child: const Text(
// // //                 'Add New Card',
// // //                 style: TextStyle(
// // //                   fontSize: 20,
// // //                   color: Colors.white,
// // //                   fontWeight: FontWeight.bold,
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class AddCardForm extends StatefulWidget {
// // //   final void Function(String cardNumber, String expiryDate) onAddCard;

// // //   const AddCardForm({super.key, required this.onAddCard});

// // //   @override
// // //   State<AddCardForm> createState() => _AddCardFormState();
// // // }

// // // class _AddCardFormState extends State<AddCardForm> {
// // //   final _cardNumberController = TextEditingController();
// // //   final _expiryDateController = TextEditingController();
// // //   final _formKey = GlobalKey<FormState>();

// // //   void _submit() {
// // //     if (_formKey.currentState?.validate() ?? false) {
// // //       final cardNumber = _cardNumberController.text;
// // //       final expiryDate = _expiryDateController.text;

// // //       widget.onAddCard(cardNumber, expiryDate);
// // //       Navigator.of(context).pop();
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Form(
// // //       key: _formKey,
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           TextFormField(
// // //             controller: _cardNumberController,
// // //             decoration: const InputDecoration(labelText: 'Card Number'),
// // //             keyboardType: TextInputType.number,
// // //             validator: (value) {
// // //               if (value == null || value.isEmpty) {
// // //                 return 'Please enter card number';
// // //               }
// // //               return null;
// // //             },
// // //           ),
// // //           TextFormField(
// // //             controller: _expiryDateController,
// // //             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
// // //             keyboardType: TextInputType.number,
// // //             validator: (value) {
// // //               if (value == null || value.isEmpty) {
// // //                 return 'Please enter expiry date';
// // //               }
// // //               return null;
// // //             },
// // //           ),
// // //           const SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: _submit,
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: Colors.orange,
// // //             ),
// // //             child: const Text(
// // //               'Add Card',
// // //               style: TextStyle(
// // //                 fontSize: 20,
// // //                 color: Colors.white,
// // //                 fontWeight: FontWeight.bold,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class MyPaymentCardsScreen extends StatefulWidget {
// //   const MyPaymentCardsScreen({super.key});

// //   @override
// //   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// // }

// // class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   void _addCard(String cardNumber, String expiryDate) async {
// //     final userId = _auth.currentUser?.uid;

// //     if (userId != null) {
// //       await _firestore.collection('myCards').add({
// //         'userId': userId,
// //         'cardNumber': cardNumber,
// //         'expiryDate': expiryDate,
// //       });
// //     }
// //   }

// //   void _confirmRemoveCard(String docId) {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Confirm Delete'),
// //           content: const Text('Are you sure you want to delete this card?'),
// //           actions: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: () => Navigator.of(context).pop(), // Cancel action
// //                   child: const Text(
// //                     'Cancel',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   width: 10,
// //                 ),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: () {
// //                     _removeCard(docId);
// //                     Navigator.of(context).pop(); // Close the dialog
// //                   },
// //                   child: const Text(
// //                     'Delete',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _removeCard(String docId) async {
// //     await _firestore.collection('myCards').doc(docId).delete();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final userId = _auth.currentUser?.uid;

// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(
// //           color: Colors.white,
// //         ),
// //         backgroundColor: Colors.orange,
// //         centerTitle: true,
// //         title: const Text(
// //           'My Payment Cards',
// //           style: TextStyle(
// //             fontSize: 25,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: StreamBuilder<QuerySnapshot>(
// //                 stream: _firestore
// //                     .collection('myCards')
// //                     .where('userId', isEqualTo: userId)
// //                     .snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }

// //                   final cards = snapshot.data?.docs ?? [];

// //                   if (cards.isEmpty) {
// //                     return const Center(
// //                       child: Text(
// //                         'No cards found',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     );
// //                   }

// //                   return ListView.builder(
// //                     physics: const BouncingScrollPhysics(),
// //                     itemCount: cards.length,
// //                     itemBuilder: (context, index) {
// //                       final cardData =
// //                           cards[index].data() as Map<String, dynamic>;
// //                       final cardNumber = cardData['cardNumber'] ?? 'Unknown';
// //                       final expiryDate = cardData['expiryDate'] ?? 'Unknown';

// //                       return Card(
// //                         color: Colors.orange,
// //                         margin: const EdgeInsets.symmetric(vertical: 8.0),
// //                         child: ListTile(
// //                           contentPadding: const EdgeInsets.all(16.0),
// //                           title: Text(
// //                             cardNumber,
// //                             style: const TextStyle(
// //                                 fontSize: 16, fontWeight: FontWeight.bold),
// //                           ),
// //                           subtitle: Text(
// //                             'Expires: $expiryDate',
// //                             style: const TextStyle(fontSize: 14),
// //                           ),
// //                           trailing: IconButton(
// //                             icon: const Icon(Icons.delete, color: Colors.red),
// //                             onPressed: () =>
// //                                 _confirmRemoveCard(cards[index].id),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 showDialog(
// //                   context: context,
// //                   builder: (context) {
// //                     return AlertDialog(
// //                       title: const Text('Add New Card'),
// //                       content: AddCardForm(onAddCard: _addCard),
// //                     );
// //                   },
// //                 );
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.orange,
// //               ),
// //               child: const Text(
// //                 'Add New Card',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class AddCardForm extends StatefulWidget {
// //   final void Function(String cardNumber, String expiryDate) onAddCard;

// //   const AddCardForm({super.key, required this.onAddCard});

// //   @override
// //   State<AddCardForm> createState() => _AddCardFormState();
// // }

// // class _AddCardFormState extends State<AddCardForm> {
// //   final _cardNumberController = TextEditingController();
// //   final _expiryDateController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   void initState() {
// //     super.initState();

// //     _cardNumberController.addListener(() {
// //       final text = _cardNumberController.text;
// //       // Remove all spaces
// //       String cleanedText = text.replaceAll(RegExp(r'\s+'), '');
// //       if (cleanedText.length > 16) {
// //         cleanedText = cleanedText.substring(0, 16); // Limit to 16 digits
// //       }

// //       // Insert space every 4 digits
// //       final formattedText = cleanedText.replaceAllMapped(
// //           RegExp(r".{4}"), (match) => "${match.group(0)} ");

// //       _cardNumberController.value = TextEditingValue(
// //         text: formattedText.trim(), // Set the text with spaces
// //         selection: TextSelection.collapsed(
// //             offset: formattedText.length), // Maintain cursor position
// //       );
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _cardNumberController.dispose();
// //     _expiryDateController.dispose();
// //     super.dispose();
// //   }

// //   void _submit() {
// //     if (_formKey.currentState?.validate() ?? false) {
// //       final cardNumber = _cardNumberController.text
// //           .replaceAll(' ', ''); // Remove spaces before saving
// //       final expiryDate = _expiryDateController.text;

// //       widget.onAddCard(cardNumber, expiryDate);
// //       Navigator.of(context).pop();
// //     }
// //   }

// //   void _showCardNumberErrorDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Invalid Card Number'),
// //           content: const Text(
// //             'Card number cannot be more than 16 digits.',
// //             style: TextStyle(
// //               fontSize: 18,
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text(
// //                 'OK',
// //                 style: TextStyle(
// //                   color: Colors.orange,
// //                   fontSize: 20,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           TextFormField(
// //             controller: _cardNumberController,
// //             decoration: const InputDecoration(labelText: 'Card Number'),
// //             keyboardType: TextInputType.number,
// //             validator: (value) {
// //               if (value == null || value.isEmpty) {
// //                 return 'Please enter card number';
// //               }
// //               if (value.replaceAll(' ', '').length != 16) {
// //                 _showCardNumberErrorDialog();
// //                 return 'Card number must be 16 digits';
// //               }
// //               return null;
// //             },
// //           ),
// //           TextFormField(
// //             controller: _expiryDateController,
// //             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
// //             keyboardType: TextInputType.number,
// //             validator: (value) {
// //               if (value == null || value.isEmpty) {
// //                 return 'Please enter expiry date';
// //               }
// //               return null;
// //             },
// //           ),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: _submit,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.orange,
// //             ),
// //             child: const Text(
// //               'Add Card',
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // class _AddCardFormState extends State<AddCardForm> {
// // //   final _cardNumberController = TextEditingController();
// // //   final _expiryDateController = TextEditingController();
// // //   final _formKey = GlobalKey<FormState>();

// // //   void _submit() {
// // //     if (_formKey.currentState?.validate() ?? false) {
// // //       final cardNumber = _cardNumberController.text;
// // //       final expiryDate = _expiryDateController.text;

// // //       widget.onAddCard(cardNumber, expiryDate);
// // //       Navigator.of(context).pop();
// // //     }
// // //   }

// // //   void _showCardNumberErrorDialog() {
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return AlertDialog(
// // //           title: const Text('Invalid Card Number'),
// // //           content: const Text(
// // //             'Card number cannot be more than 16 digits.',
// // //             style: TextStyle(
// // //               fontSize: 18,
// // //             ),
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.of(context).pop(),
// // //               child: const Text(
// // //                 'OK',
// // //                 style: TextStyle(
// // //                   color: Colors.orange,
// // //                   fontSize: 20,
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Form(
// // //       key: _formKey,
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           TextFormField(
// // //             controller: _cardNumberController,
// // //             decoration: const InputDecoration(labelText: 'Card Number'),
// // //             keyboardType: TextInputType.number,
// // //             validator: (value) {
// // //               if (value == null || value.isEmpty) {
// // //                 return 'Please enter card number';
// // //               }
// // //               if (value.length > 16 || value.length < 16) {
// // //                 _showCardNumberErrorDialog();
// // //                 return 'Card number must be 16 digits';
// // //               }
// // //               return null;
// // //             },
// // //           ),
// // //           TextFormField(
// // //             controller: _expiryDateController,
// // //             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
// // //             keyboardType: TextInputType.number,
// // //             validator: (value) {
// // //               if (value == null || value.isEmpty) {
// // //                 return 'Please enter expiry date';
// // //               }
// // //               return null;
// // //             },
// // //           ),
// // //           const SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: _submit,
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: Colors.orange,
// // //             ),
// // //             child: const Text(
// // //               'Add Card',
// // //               style: TextStyle(
// // //                 fontSize: 20,
// // //                 color: Colors.white,
// // //                 fontWeight: FontWeight.bold,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/services.dart';

// // class MyPaymentCardsScreen extends StatefulWidget {
// //   const MyPaymentCardsScreen({super.key});

// //   @override
// //   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// // }

// // class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   void _addCard(String cardNumber, String expiryDate) async {
// //     final userId = _auth.currentUser?.uid;

// //     if (userId != null) {
// //       await _firestore.collection('myCards').add({
// //         'userId': userId,
// //         'cardNumber': cardNumber,
// //         'expiryDate': expiryDate,
// //       });
// //     }
// //   }

// //   void _confirmRemoveCard(String docId) {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Confirm Delete'),
// //           content: const Text('Are you sure you want to delete this card?'),
// //           actions: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: () => Navigator.of(context).pop(), // Cancel action
// //                   child: const Text(
// //                     'Cancel',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   width: 10,
// //                 ),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: () {
// //                     _removeCard(docId);
// //                     Navigator.of(context).pop(); // Close the dialog
// //                   },
// //                   child: const Text(
// //                     'Delete',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _removeCard(String docId) async {
// //     await _firestore.collection('myCards').doc(docId).delete();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final userId = _auth.currentUser?.uid;

// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(
// //           color: Colors.white,
// //         ),
// //         backgroundColor: Colors.orange,
// //         centerTitle: true,
// //         title: const Text(
// //           'My Payment Cards',
// //           style: TextStyle(
// //             fontSize: 25,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: StreamBuilder<QuerySnapshot>(
// //                 stream: _firestore
// //                     .collection('myCards')
// //                     .where('userId', isEqualTo: userId)
// //                     .snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }

// //                   final cards = snapshot.data?.docs ?? [];

// //                   if (cards.isEmpty) {
// //                     return const Center(
// //                       child: Text(
// //                         'No cards found',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     );
// //                   }

// //                   return ListView.builder(
// //                     physics: const BouncingScrollPhysics(),
// //                     itemCount: cards.length,
// //                     itemBuilder: (context, index) {
// //                       final cardData =
// //                           cards[index].data() as Map<String, dynamic>;
// //                       final cardNumber = cardData['cardNumber'] ?? 'Unknown';
// //                       final expiryDate = cardData['expiryDate'] ?? 'Unknown';

// //                       return Card(
// //                         color: Colors.orange,
// //                         margin: const EdgeInsets.symmetric(vertical: 8.0),
// //                         child: ListTile(
// //                           contentPadding: const EdgeInsets.all(16.0),
// //                           title: Text(
// //                             cardNumber,
// //                             style: const TextStyle(
// //                                 fontSize: 16, fontWeight: FontWeight.bold),
// //                           ),
// //                           subtitle: Text(
// //                             'Expires: $expiryDate',
// //                             style: const TextStyle(fontSize: 14),
// //                           ),
// //                           trailing: IconButton(
// //                             icon: const Icon(Icons.delete, color: Colors.red),
// //                             onPressed: () =>
// //                                 _confirmRemoveCard(cards[index].id),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 showDialog(
// //                   context: context,
// //                   builder: (context) {
// //                     return AlertDialog(
// //                       title: const Text('Add New Card'),
// //                       content: AddCardForm(onAddCard: _addCard),
// //                     );
// //                   },
// //                 );
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.orange,
// //               ),
// //               child: const Text(
// //                 'Add New Card',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class AddCardForm extends StatefulWidget {
// //   final void Function(String cardNumber, String expiryDate) onAddCard;

// //   const AddCardForm({super.key, required this.onAddCard});

// //   @override
// //   State<AddCardForm> createState() => _AddCardFormState();
// // }

// // class _AddCardFormState extends State<AddCardForm> {
// //   final _cardNumberController = TextEditingController();
// //   final _expiryDateController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();

// //   void _submit() {
// //     if (_formKey.currentState?.validate() ?? false) {
// //       final cardNumber = _cardNumberController.text.replaceAll(' ', '');
// //       final expiryDate = _expiryDateController.text;

// //       widget.onAddCard(cardNumber, expiryDate);
// //       Navigator.of(context).pop();
// //     }
// //   }

// //   void _showCardNumberErrorDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text('Invalid Card Number'),
// //           content: const Text(
// //             'Card number cannot be more than 16 digits.',
// //             style: TextStyle(
// //               fontSize: 18,
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text(
// //                 'OK',
// //                 style: TextStyle(
// //                   color: Colors.orange,
// //                   fontSize: 20,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           TextFormField(
// //             controller: _cardNumberController,
// //             decoration: const InputDecoration(labelText: 'Card Number'),
// //             keyboardType: TextInputType.number,
// //             inputFormatters: [
// //               FilteringTextInputFormatter.digitsOnly,
// //               CardNumberInputFormatter(),
// //             ],
// //             validator: (value) {
// //               if (value == null || value.isEmpty) {
// //                 return 'Please enter card number';
// //               }
// //               if (value.replaceAll(' ', '').length != 16) {
// //                 _showCardNumberErrorDialog();
// //                 return 'Card number must be exactly 16 digits';
// //               }
// //               return null;
// //             },
// //           ),
// //           TextFormField(
// //             controller: _expiryDateController,
// //             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
// //             keyboardType: TextInputType.number,
// //             validator: (value) {
// //               if (value == null || value.isEmpty) {
// //                 return 'Please enter expiry date';
// //               }
// //               return null;
// //             },
// //           ),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: _submit,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.orange,
// //             ),
// //             child: const Text(
// //               'Add Card',
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CardNumberInputFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //     TextEditingValue oldValue,
// //     TextEditingValue newValue,
// //   ) {
// //     final text = newValue.text.replaceAll(' ', '');
// //     final buffer = StringBuffer();

// //     for (int i = 0; i < text.length; i++) {
// //       buffer.write(text[i]);
// //       if (i % 4 == 3 && i != text.length - 1) {
// //         buffer.write(' '); // Add space every 4 digits
// //       }
// //     }

// //     return TextEditingValue(
// //       text: buffer.toString(),
// //       selection: TextSelection.collapsed(offset: buffer.length),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';

// class MyPaymentCardsScreen extends StatefulWidget {
//   const MyPaymentCardsScreen({super.key});

//   @override
//   State<MyPaymentCardsScreen> createState() => _MyPaymentCardsScreenState();
// }

// class _MyPaymentCardsScreenState extends State<MyPaymentCardsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void _addCard(String cardNumber, String expiryDate) async {
//     final userId = _auth.currentUser?.uid;

//     if (userId != null) {
//       await _firestore.collection('myCards').add({
//         'userId': userId,
//         'cardNumber': cardNumber,
//         'expiryDate': expiryDate,
//       });
//     }
//   }

//   void _confirmRemoveCard(String docId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirm Delete'),
//           content: const Text('Are you sure you want to delete this card?'),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                   ),
//                   onPressed: () => Navigator.of(context).pop(), // Cancel action
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                   ),
//                   onPressed: () {
//                     _removeCard(docId);
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: const Text(
//                     'Delete',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }

//   void _removeCard(String docId) async {
//     await _firestore.collection('myCards').doc(docId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userId = _auth.currentUser?.uid;

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.orange,
//         centerTitle: true,
//         title: const Text(
//           'My Payment Cards',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('myCards')
//                     .where('userId', isEqualTo: userId)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final cards = snapshot.data?.docs ?? [];

//                   if (cards.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         'No cards found',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: cards.length,
//                     itemBuilder: (context, index) {
//                       final cardData =
//                           cards[index].data() as Map<String, dynamic>;
//                       final cardNumber = cardData['cardNumber'] ?? 'Unknown';
//                       final expiryDate = cardData['expiryDate'] ?? 'Unknown';

//                       return Card(
//                         color: Colors.orange,
//                         margin: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(16.0),
//                           title: Text(
//                             _formatCardNumber(cardNumber),
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             'Expires: $expiryDate',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () =>
//                                 _confirmRemoveCard(cards[index].id),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Add New Card'),
//                       content: AddCardForm(onAddCard: _addCard),
//                     );
//                   },
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//               ),
//               child: const Text(
//                 'Add New Card',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatCardNumber(String cardNumber) {
//     final buffer = StringBuffer();
//     for (int i = 0; i < cardNumber.length; i++) {
//       buffer.write(cardNumber[i]);
//       if ((i + 1) % 4 == 0 && i != cardNumber.length - 1) {
//         buffer.write(' '); // Add space every 4 digits
//       }
//     }
//     return buffer.toString();
//   }
// }

// class AddCardForm extends StatefulWidget {
//   final void Function(String cardNumber, String expiryDate) onAddCard;

//   const AddCardForm({super.key, required this.onAddCard});

//   @override
//   State<AddCardForm> createState() => _AddCardFormState();
// }

// class _AddCardFormState extends State<AddCardForm> {
//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   void _submit() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final cardNumber = _cardNumberController.text.replaceAll(' ', '');
//       final expiryDate = _expiryDateController.text;

//       widget.onAddCard(cardNumber, expiryDate);
//       Navigator.of(context).pop();
//     }
//   }

//   void _showCardNumberErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Invalid Card Number'),
//           content: const Text(
//             'Card number cannot be more than 16 digits.',
//             style: TextStyle(
//               fontSize: 18,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'OK',
//                 style: TextStyle(
//                   color: Colors.orange,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: _cardNumberController,
//             decoration: const InputDecoration(labelText: 'Card Number'),
//             keyboardType: TextInputType.number,
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//               CardNumberInputFormatter(),
//             ],
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter card number';
//               }
//               if (value.replaceAll(' ', '').length != 16) {
//                 _showCardNumberErrorDialog();
//                 return 'Card number must be exactly 16 digits';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _expiryDateController,
//             decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter expiry date';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submit,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//             ),
//             child: const Text(
//               'Add Card',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CardNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final newText = newValue.text.replaceAll(' ', '');
//     if (newText.isEmpty) {
//       return newValue.copyWith(text: '');
//     }

//     final buffer = StringBuffer();
//     for (int i = 0; i < newText.length; i++) {
//       buffer.write(newText[i]);
//       if ((i + 1) % 4 == 0 && i != newText.length - 1) {
//         buffer.write(' '); // Add space every 4 digits
//       }
//     }
//     return newValue.copyWith(text: buffer.toString());
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this card?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () => Navigator.of(context).pop(), // Cancel action
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    _removeCard(docId);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
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
                    return const Center(child: CircularProgressIndicator());
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
                      final cardNumber = cardData['cardNumber'] ?? 'Unknown';
                      final expiryDate = cardData['expiryDate'] ?? 'Unknown';

                      return Card(
                        color: Colors.orange,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            _formatCardNumber(cardNumber),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Expires: $expiryDate',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmRemoveCard(cards[index].id),
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

class AddCardForm extends StatefulWidget {
  final void Function(String cardNumber, String expiryDate) onAddCard;

  const AddCardForm({super.key, required this.onAddCard});

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final cardNumber = _cardNumberController.text.replaceAll(' ', '');
      final expiryDate = _expiryDateController.text;

      widget.onAddCard(cardNumber, expiryDate);
      Navigator.of(context).pop();
    }
  }

  void _showCardNumberErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Card Number'),
          content: const Text(
            'Card number must be exactly 16 digits.',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _cardNumberController,
            decoration: const InputDecoration(labelText: 'Card Number'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberInputFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              if (value.replaceAll(' ', '').length != 16) {
                _showCardNumberErrorDialog();
                return 'Card number must be exactly 16 digits';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _expiryDateController,
            decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter expiry date';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text(
              'Add Card',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(' ', '');
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if ((i + 1) % 4 == 0 && i != newText.length - 1) {
        buffer.write(' '); // Add space every 4 digits
      }
    }
    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
