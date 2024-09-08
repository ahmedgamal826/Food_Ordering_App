// // // // // // import 'package:flutter/material.dart';

// // // // // // class OrderInProfileUser extends StatelessWidget {
// // // // // //   final double deliveryPrice;
// // // // // //   final double total;
// // // // // //   final String customerName;
// // // // // //   final List<dynamic> items;
// // // // // //   final String deliveryAddress;

// // // // // //   const OrderInProfileUser({
// // // // // //     super.key,
// // // // // //     required this.deliveryPrice,
// // // // // //     required this.total,
// // // // // //     required this.customerName,
// // // // // //     required this.items,
// // // // // //     required this.deliveryAddress,
// // // // // //   });

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Order Details'),
// // // // // //         backgroundColor: Colors.orange,
// // // // // //       ),
// // // // // //       body: Padding(
// // // // // //         padding: const EdgeInsets.all(16.0),
// // // // // //         child: ListView(
// // // // // //           children: <Widget>[
// // // // // //             Text(
// // // // // //               'Customer Name: $customerName',
// // // // // //               style: TextStyle(fontSize: 18),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             Text(
// // // // // //               'Delivery Address: $deliveryAddress',
// // // // // //               style: TextStyle(fontSize: 18),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             Text(
// // // // // //               'Delivery Price: \$${deliveryPrice.toStringAsFixed(2)}',
// // // // // //               style: TextStyle(fontSize: 18),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             Text(
// // // // // //               'Total: \$${total.toStringAsFixed(2)}',
// // // // // //               style: TextStyle(fontSize: 18),
// // // // // //             ),
// // // // // //             SizedBox(height: 20),
// // // // // //             Text(
// // // // // //               'Products:',
// // // // // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // // //             ),
// // // // // //             ...items.map((item) {
// // // // // //               final product = item['product'] as Map<String, dynamic>? ?? {};
// // // // // //               final productName = product['name'] as String? ?? '';
// // // // // //               final quantity = item['quantity'] as int? ?? 0;
// // // // // //               final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

// // // // // //               return ListTile(
// // // // // //                 title: Text('$productName'),
// // // // // //                 subtitle: Text('Quantity: $quantity'),
// // // // // //                 trailing: Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
// // // // // //               );
// // // // // //             }).toList(),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // class OrderInProfileUser extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('My Orders'),
// // // // //         backgroundColor: Colors.orange,
// // // // //       ),
// // // // //       body: StreamBuilder(
// // // // //         stream: FirebaseFirestore.instance.collection('cartsUser').snapshots(),
// // // // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // //             return Center(child: CircularProgressIndicator());
// // // // //           }

// // // // //           if (snapshot.hasError) {
// // // // //             return Center(child: Text('Error: ${snapshot.error}'));
// // // // //           }

// // // // //           final orders = snapshot.data?.docs ?? [];

// // // // //           return ListView.builder(
// // // // //             itemCount: orders.length,
// // // // //             itemBuilder: (context, index) {
// // // // //               final order = orders[index].data() as Map<String, dynamic>;
// // // // //               final items =
// // // // //                   order['items'] as List<dynamic>; // Ensure 'items' is a List

// // // // //               return Card(
// // // // //                 margin: EdgeInsets.all(8.0),
// // // // //                 elevation: 4.0,
// // // // //                 child: Padding(
// // // // //                   padding: EdgeInsets.all(8.0),
// // // // //                   child: Column(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Text(
// // // // //                         'Order for ${order['customerName']}',
// // // // //                       ),
// // // // //                       Text(
// // // // //                         'Total: \$${order['total']}',
// // // // //                       ),
// // // // //                       SizedBox(height: 8.0),
// // // // //                       Text(
// // // // //                         'Items:',
// // // // //                       ),
// // // // //                       ...items.map((item) {
// // // // //                         final product =
// // // // //                             item['product'] as Map<String, dynamic>? ?? {};
// // // // //                         final productName = product['name'] as String? ?? '';
// // // // //                         final quantity = item['quantity'] as int? ?? 0;
// // // // //                         final itemTotalPrice =
// // // // //                             item['totalPrice'] as double? ?? 0.0;

// // // // //                         return ListTile(
// // // // //                           leading: Text(
// // // // //                             '$quantity',
// // // // //                             style: const TextStyle(
// // // // //                               fontSize: 16,
// // // // //                             ),
// // // // //                           ),
// // // // //                           title: Text(
// // // // //                             maxLines: 2,
// // // // //                             overflow: TextOverflow.ellipsis,
// // // // //                             '$productName',
// // // // //                           ),
// // // // //                           trailing: Text(
// // // // //                             '\$${itemTotalPrice.toStringAsFixed(2)}',
// // // // //                             style: const TextStyle(
// // // // //                               fontSize: 16,
// // // // //                             ),
// // // // //                           ),
// // // // //                         );
// // // // //                       }).toList(),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //               );
// // // // //             },
// // // // //           );
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // class OrderInProfileUser extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('My Orders'),
// // // //         backgroundColor: Colors.orange,
// // // //       ),
// // // //       body: StreamBuilder(
// // // //         stream: FirebaseFirestore.instance.collection('cartsUser').snapshots(),
// // // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // //             return Center(child: CircularProgressIndicator());
// // // //           }

// // // //           if (snapshot.hasError) {
// // // //             return Center(child: Text('Error: ${snapshot.error}'));
// // // //           }

// // // //           final orders = snapshot.data?.docs ?? [];

// // // //           return ListView.builder(
// // // //             itemCount: orders.length,
// // // //             itemBuilder: (context, index) {
// // // //               final order = orders[index].data() as Map<String, dynamic>;

// // // //               // Ensure 'items' is a List or an empty list if 'items' is null
// // // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // // //               return Card(
// // // //                 color: Colors.orange,
// // // //                 margin: EdgeInsets.all(8.0),
// // // //                 elevation: 4.0,
// // // //                 child: Padding(
// // // //                   padding: EdgeInsets.all(8.0),
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Text(
// // // //                         'Order for ${order['customerName'] ?? 'Unknown'}',
// // // //                       ),
// // // //                       Text(
// // // //                         'Total: \$${order['total'] ?? 0.0}',
// // // //                       ),
// // // //                       SizedBox(height: 8.0),
// // // //                       Text(
// // // //                         'Items:',
// // // //                       ),
// // // //                       ...items.map((item) {
// // // //                         final product =
// // // //                             (item['product'] as Map<String, dynamic>?) ?? {};
// // // //                         final productName = product['name'] as String? ?? '';
// // // //                         final quantity = item['quantity'] as int? ?? 0;
// // // //                         final itemTotalPrice =
// // // //                             item['totalPrice'] as double? ?? 0.0;

// // // //                         return ListTile(
// // // //                           leading: Text(
// // // //                             '$quantity',
// // // //                             style: const TextStyle(fontSize: 16),
// // // //                           ),
// // // //                           title: Text(
// // // //                             productName,
// // // //                             maxLines: 2,
// // // //                             overflow: TextOverflow.ellipsis,
// // // //                           ),
// // // //                           trailing: Text(
// // // //                             '\$${itemTotalPrice.toStringAsFixed(2)}',
// // // //                             style: const TextStyle(fontSize: 16),
// // // //                           ),
// // // //                         );
// // // //                       }).toList(),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             },
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class OrderInProfileUser extends StatelessWidget {
// // //   Future<void> _deleteOrder(String documentId) async {
// // //     final firestore = FirebaseFirestore.instance;

// // //     try {
// // //       await firestore.collection('cartsUser').doc(documentId).delete();
// // //     } catch (e) {
// // //       // Handle error
// // //       print('Error deleting order: $e');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('My Orders'),
// // //         backgroundColor: Colors.orange,
// // //       ),
// // //       body: StreamBuilder(
// // //         stream: FirebaseFirestore.instance.collection('cartsUser').snapshots(),
// // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return Center(child: CircularProgressIndicator());
// // //           }

// // //           if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           }

// // //           final orders = snapshot.data?.docs ?? [];

// // //           return ListView.builder(
// // //             itemCount: orders.length,
// // //             itemBuilder: (context, index) {
// // //               final order = orders[index].data() as Map<String, dynamic>;
// // //               final documentId = orders[index].id; // Get the document ID

// // //               // Ensure 'items' is a List or an empty list if 'items' is null
// // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // //               return Card(
// // //                 color: Colors.orange,
// // //                 margin: EdgeInsets.all(8.0),
// // //                 elevation: 4.0,
// // //                 child: Padding(
// // //                   padding: EdgeInsets.all(8.0),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Order for ${order['customerName'] ?? 'Unknown'}',
// // //                       ),
// // //                       Text(
// // //                         'Total: \$${order['total'] ?? 0.0}',
// // //                       ),
// // //                       SizedBox(height: 8.0),
// // //                       Text(
// // //                         'Items:',
// // //                       ),
// // //                       ...items.map((item) {
// // //                         final product =
// // //                             (item['product'] as Map<String, dynamic>?) ?? {};
// // //                         final productName = product['name'] as String? ?? '';
// // //                         final quantity = item['quantity'] as int? ?? 0;
// // //                         final itemTotalPrice =
// // //                             item['totalPrice'] as double? ?? 0.0;

// // //                         return ListTile(
// // //                           leading: Text(
// // //                             '$quantity',
// // //                             style: const TextStyle(fontSize: 16),
// // //                           ),
// // //                           title: Text(
// // //                             productName,
// // //                             maxLines: 2,
// // //                             overflow: TextOverflow.ellipsis,
// // //                           ),
// // //                           trailing: Text(
// // //                             '\$${itemTotalPrice.toStringAsFixed(2)}',
// // //                             style: const TextStyle(fontSize: 16),
// // //                           ),
// // //                         );
// // //                       }).toList(),
// // //                       // Add Delete Button
// // //                       Align(
// // //                         alignment: Alignment.centerRight,
// // //                         child: TextButton(
// // //                           onPressed: () async {
// // //                             bool confirm = await showDialog(
// // //                               context: context,
// // //                               builder: (context) => AlertDialog(
// // //                                 title: Text('Delete Order'),
// // //                                 content: Text(
// // //                                     'Are you sure you want to delete this order?'),
// // //                                 actions: [
// // //                                   TextButton(
// // //                                     onPressed: () =>
// // //                                         Navigator.of(context).pop(false),
// // //                                     child: Text('Cancel'),
// // //                                   ),
// // //                                   TextButton(
// // //                                     onPressed: () =>
// // //                                         Navigator.of(context).pop(true),
// // //                                     child: Text('Delete'),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             );

// // //                             if (confirm) {
// // //                               await _deleteOrder(documentId);
// // //                             }
// // //                           },
// // //                           child: Text(
// // //                             'Delete',
// // //                             style: TextStyle(color: Colors.red),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:intl/intl.dart'; // Add this for date formatting

// // // class OrderInProfileUser extends StatelessWidget {
// // //   Future<void> _deleteOrder(String documentId) async {
// // //     final firestore = FirebaseFirestore.instance;

// // //     try {
// // //       await firestore.collection('cartsUser').doc(documentId).delete();
// // //     } catch (e) {
// // //       // Handle error
// // //       print('Error deleting order: $e');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         iconTheme: const IconThemeData(
// // //           color: Colors.white,
// // //         ),
// // //         centerTitle: true,
// // //         title: const Text(
// // //           'My Orders',
// // //           style: TextStyle(
// // //             fontSize: 25,
// // //             color: Colors.white,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.orange,
// // //       ),
// // //       body: StreamBuilder(
// // //         stream: FirebaseFirestore.instance.collection('cartsUser').snapshots(),
// // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return Center(child: CircularProgressIndicator());
// // //           }

// // //           if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           }

// // //           final orders = snapshot.data?.docs ?? [];

// // //           return ListView.builder(
// // //             itemCount: orders.length,
// // //             itemBuilder: (context, index) {
// // //               final order = orders[index].data() as Map<String, dynamic>;
// // //               final documentId = orders[index].id; // Get the document ID

// // //               // Ensure 'items' is a List or an empty list if 'items' is null
// // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // //               // Fetch and format the timestamp
// // //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// // //               final formattedTime = timestamp != null
// // //                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
// // //                   : 'Unknown Time';

// // //               return Card(
// // //                 color: Colors.orange,
// // //                 margin: EdgeInsets.all(8.0),
// // //                 elevation: 4.0,
// // //                 child: Padding(
// // //                   padding: EdgeInsets.all(8.0),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Order Time: $formattedTime',
// // //                         style: TextStyle(
// // //                           fontSize: 20,
// // //                           color: Colors.white,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       SizedBox(height: 8.0),
// // //                       Text(
// // //                         'Orders:',
// // //                         style: TextStyle(
// // //                           fontSize: 20,
// // //                           color: Colors.white,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       ...items.map((item) {
// // //                         final product =
// // //                             (item['product'] as Map<String, dynamic>?) ?? {};
// // //                         final productName = product['name'] as String? ?? '';
// // //                         final quantity = item['quantity'] as int? ?? 0;
// // //                         final itemTotalPrice =
// // //                             item['totalPrice'] as double? ?? 0.0;

// // //                         return ListTile(
// // //                           leading: Text(
// // //                             '$quantity',
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           title: Text(
// // //                             productName,
// // //                             maxLines: 2,
// // //                             overflow: TextOverflow.ellipsis,
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           trailing: Text(
// // //                             '\$${itemTotalPrice.toStringAsFixed(2)}',
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                         );
// // //                       }).toList(),
// // //                       // Add Delete Button
// // //                       Row(
// // //                         mainAxisAlignment: MainAxisAlignment.center,
// // //                         children: [
// // //                           Text(
// // //                             'Total: \$${order['total'] ?? 0.0}',
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           Align(
// // //                             alignment: Alignment.centerRight,
// // //                             child: TextButton(
// // //                               onPressed: () async {
// // //                                 bool confirm = await showDialog(
// // //                                   context: context,
// // //                                   builder: (context) => AlertDialog(
// // //                                     title: Text('Delete Order'),
// // //                                     content: Text(
// // //                                         'Are you sure you want to delete this order?'),
// // //                                     actions: [
// // //                                       TextButton(
// // //                                         onPressed: () =>
// // //                                             Navigator.of(context).pop(false),
// // //                                         child: Text('Cancel'),
// // //                                       ),
// // //                                       TextButton(
// // //                                         onPressed: () =>
// // //                                             Navigator.of(context).pop(true),
// // //                                         child: Text('Delete'),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 );

// // //                                 if (confirm) {
// // //                                   await _deleteOrder(documentId);
// // //                                 }
// // //                               },
// // //                               child: Text(
// // //                                 'Delete',
// // //                                 style: TextStyle(color: Colors.red),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:intl/intl.dart'; // Add this for date formatting

// // // class OrderInProfileUser extends StatelessWidget {
// // //   Future<void> _deleteOrder(String documentId) async {
// // //     final firestore = FirebaseFirestore.instance;

// // //     try {
// // //       await firestore.collection('cartsUser').doc(documentId).delete();
// // //     } catch (e) {
// // //       // Handle error
// // //       print('Error deleting order: $e');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         iconTheme: const IconThemeData(
// // //           color: Colors.white,
// // //         ),
// // //         centerTitle: true,
// // //         title: const Text(
// // //           'My Orders',
// // //           style: TextStyle(
// // //             fontSize: 25,
// // //             color: Colors.white,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.orange,
// // //       ),
// // //       body: StreamBuilder(
// // //         stream: FirebaseFirestore.instance.collection('cartsUser').snapshots(),
// // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return Center(child: CircularProgressIndicator());
// // //           }

// // //           if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           }

// // //           final orders = snapshot.data?.docs ?? [];

// // //           return ListView.builder(
// // //             itemCount: orders.length,
// // //             itemBuilder: (context, index) {
// // //               final order = orders[index].data() as Map<String, dynamic>;
// // //               final documentId = orders[index].id; // Get the document ID

// // //               // Ensure 'items' is a List or an empty list if 'items' is null
// // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // //               // Fetch and format the timestamp
// // //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// // //               final formattedTime = timestamp != null
// // //                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
// // //                   : 'Unknown Time';

// // //               return Column(
// // //                 children: [
// // //                   const SizedBox(
// // //                     height: 20,
// // //                   ),
// // //                   Text(
// // //                     'Order Time: $formattedTime',
// // //                     style: const TextStyle(
// // //                       fontSize: 20,
// // //                       color: Colors.black,
// // //                       fontWeight: FontWeight.bold,
// // //                     ),
// // //                   ),
// // //                   ...items.map((item) {
// // //                     final product =
// // //                         (item['product'] as Map<String, dynamic>?) ?? {};
// // //                     final productName = product['name'] as String? ?? '';
// // //                     final quantity = item['quantity'] as int? ?? 0;
// // //                     final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

// // //                     return Card(
// // //                       color: Colors.orange,
// // //                       margin: EdgeInsets.all(8.0),
// // //                       elevation: 4.0,
// // //                       child: Padding(
// // //                         padding: EdgeInsets.all(8.0),
// // //                         child: ListTile(
// // //                           leading: Text(
// // //                             '$quantity',
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           title: Text(
// // //                             productName,
// // //                             maxLines: 2,
// // //                             overflow: TextOverflow.ellipsis,
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           trailing: Text(
// // //                             '\$${itemTotalPrice.toStringAsFixed(2)}',
// // //                             style: TextStyle(
// // //                               fontSize: 20,
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     );
// // //                   }).toList(),
// // //                   // Add Delete Button for the order
// // //                   Padding(
// // //                     padding: EdgeInsets.symmetric(vertical: 8.0),
// // //                     child: Row(
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         Text(
// // //                           'Total: \$${order['total'] ?? 0.0}',
// // //                           style: TextStyle(
// // //                             fontSize: 20,
// // //                             color: Colors.black,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                         SizedBox(width: 16.0),
// // //                         TextButton(
// // //                           onPressed: () async {
// // //                             bool confirm = await showDialog(
// // //                               context: context,
// // //                               builder: (context) => AlertDialog(
// // //                                 title: Text('Delete Order'),
// // //                                 content: Text(
// // //                                     'Are you sure you want to delete this order?'),
// // //                                 actions: [
// // //                                   TextButton(
// // //                                     onPressed: () =>
// // //                                         Navigator.of(context).pop(false),
// // //                                     child: Text('Cancel'),
// // //                                   ),
// // //                                   TextButton(
// // //                                     onPressed: () =>
// // //                                         Navigator.of(context).pop(true),
// // //                                     child: Text('Delete'),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             );

// // //                             if (confirm) {
// // //                               await _deleteOrder(documentId);
// // //                             }
// // //                           },
// // //                           child: Text(
// // //                             'Delete Order',
// // //                             style: TextStyle(color: Colors.red),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   Divider(
// // //                     color: Colors.orange,
// // //                     indent: 25,
// // //                     endIndent: 25,
// // //                     thickness: 3,
// // //                   )
// // //                 ],
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart'; // Add this for date formatting

// // class OrderInProfileUser extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(
// //           color: Colors.white,
// //         ),
// //         centerTitle: true,
// //         title: const Text(
// //           'My Orders',
// //           style: TextStyle(
// //             fontSize: 25,
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection('cartsUser')
// //             .orderBy('timestamp',
// //                 descending: true) // Sort by timestamp in descending order
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(
// //               child: CircularProgressIndicator(
// //                 color: Colors.orange,
// //               ),
// //             );
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }

// //           final orders = snapshot.data?.docs ?? [];

// //           return ListView.builder(
// //             physics: const BouncingScrollPhysics(),
// //             itemCount: orders.length,
// //             itemBuilder: (context, index) {
// //               final order = orders[index].data() as Map<String, dynamic>;
// //               final documentId = orders[index].id; // Get the document ID

// //               // Ensure 'items' is a List or an empty list if 'items' is null
// //               final items = (order['items'] as List<dynamic>?) ?? [];

// //               // Fetch and format the timestamp
// //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// //               final formattedTime = timestamp != null
// //                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
// //                   : 'Unknown Time';

// //               return Card(
// //                 color: Colors.grey,
// //                 child: Column(
// //                   children: [
// //                     const SizedBox(
// //                       height: 20,
// //                     ),
// //                     Text(
// //                       'Order Time: $formattedTime',
// //                       style: const TextStyle(
// //                         fontSize: 20,
// //                         color: Colors.black,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     ...items.map((item) {
// //                       final product =
// //                           (item['product'] as Map<String, dynamic>?) ?? {};
// //                       final productName = product['name'] as String? ?? '';
// //                       final quantity = item['quantity'] as int? ?? 0;
// //                       final itemTotalPrice =
// //                           item['totalPrice'] as double? ?? 0.0;

// //                       return Card(
// //                         color: Colors.orange,
// //                         margin: const EdgeInsets.all(8.0),
// //                         elevation: 4.0,
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: ListTile(
// //                             leading: Text(
// //                               '$quantity',
// //                               style: const TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             title: Text(
// //                               productName,
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             trailing: Text(
// //                               '\$${itemTotalPrice.toStringAsFixed(2)}',
// //                               style: const TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }).toList(),
// //                     // Add Delete Button for the order
// //                     // Padding(
// //                     //   padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                     //   child: Row(
// //                     //     mainAxisAlignment: MainAxisAlignment.center,
// //                     //     children: [
// //                     //       Text(
// //                     //         'Total: \$${order['total'] ?? 0.0}',
// //                     //         style: const TextStyle(
// //                     //           fontSize: 20,
// //                     //           color: Colors.black,
// //                     //           fontWeight: FontWeight.bold,
// //                     //         ),
// //                     //       ),
// //                     //       const SizedBox(width: 16.0),
// //                     //     ],
// //                     //   ),
// //                     // ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';

// class OrderInProfileUser extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userId =
//         FirebaseAuth.instance.currentUser?.uid; // Get the current user's ID

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         centerTitle: true,
//         title: const Text(
//           'My Orders',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.orange,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('cartsUser')
//             .where('userId',
//                 isEqualTo: userId) // Filter orders by current user ID
//             .orderBy('timestamp', descending: true) // Sort by timestamp
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.orange,
//               ),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final orders = snapshot.data?.docs ?? [];

//           if (orders.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No orders found.',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               ),
//             );
//           }

//           return ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index].data() as Map<String, dynamic>;
//               final documentId = orders[index].id;

//               final items = (order['items'] as List<dynamic>?) ?? [];
//               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
//               final formattedTime = timestamp != null
//                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
//                   : 'Unknown Time';

//               return Card(
//                 color: Colors.grey,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       'Order Time: $formattedTime',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     ...items.map((item) {
//                       final product =
//                           (item['product'] as Map<String, dynamic>?) ?? {};
//                       final productName = product['name'] as String? ?? '';
//                       final quantity = item['quantity'] as int? ?? 0;
//                       final itemTotalPrice =
//                           item['totalPrice'] as double? ?? 0.0;

//                       return Card(
//                         color: Colors.orange,
//                         margin: const EdgeInsets.all(8.0),
//                         elevation: 4.0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ListTile(
//                             leading: Text(
//                               '$quantity',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             title: Text(
//                               productName,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             trailing: Text(
//                               '\$${itemTotalPrice.toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import FirebaseAuth

class OrderInProfileUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: userId == null
          ? const Center(
              child: Text(
                'User not logged in.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cartsUser')
                  .where('userId', isEqualTo: userId) // Filter by userId
                  .orderBy('timestamp', descending: true) // Sort by timestamp
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final orders = snapshot.data?.docs ?? [];

                if (orders.isEmpty) {
                  return const Center(
                    child: Text(
                      'No orders found.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index].data() as Map<String, dynamic>;
                    final documentId = orders[index].id;

                    final items = (order['items'] as List<dynamic>?) ?? [];
                    final timestamp =
                        (order['timestamp'] as Timestamp?)?.toDate();
                    final formattedTime = timestamp != null
                        ? DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp)
                        : 'Unknown Time';

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
                            final product =
                                (item['product'] as Map<String, dynamic>?) ??
                                    {};
                            final productName =
                                product['name'] as String? ?? '';
                            final quantity = item['quantity'] as int? ?? 0;
                            final itemTotalPrice =
                                item['totalPrice'] as double? ?? 0.0;

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
                  },
                );
              },
            ),
    );
  }
}
