// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:intl/intl.dart';

// // // // class BillsScreen extends StatefulWidget {
// // // //   const BillsScreen({super.key});

// // // //   @override
// // // //   State<BillsScreen> createState() => _BillsScreenState();
// // // // }

// // // // class _BillsScreenState extends State<BillsScreen> {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         iconTheme: const IconThemeData(
// // // //           color: Colors.white,
// // // //         ),
// // // //         centerTitle: true,
// // // //         title: const Text(
// // // //           'My Bills',
// // // //           style: TextStyle(
// // // //             fontSize: 25,
// // // //             color: Colors.white,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         backgroundColor: Colors.orange,
// // // //       ),
// // // //       body: StreamBuilder(
// // // //         stream: FirebaseFirestore.instance
// // // //             .collection('cartsUser')
// // // //             .orderBy('timestamp',
// // // //                 descending: true) // Sort by timestamp in descending order
// // // //             .snapshots(),
// // // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // //             return const Center(
// // // //               child: CircularProgressIndicator(
// // // //                 color: Colors.orange,
// // // //               ),
// // // //             );
// // // //           }

// // // //           if (snapshot.hasError) {
// // // //             return Center(child: Text('Error: ${snapshot.error}'));
// // // //           }

// // // //           final orders = snapshot.data?.docs ?? [];

// // // //           return ListView.builder(
// // // //             physics: const BouncingScrollPhysics(),
// // // //             itemCount: orders.length,
// // // //             itemBuilder: (context, index) {
// // // //               final order = orders[index].data() as Map<String, dynamic>;
// // // //               final documentId = orders[index].id; // Get the document ID

// // // //               // Ensure 'items' is a List or an empty list if 'items' is null
// // // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // // //               // Fetch and format the timestamp
// // // //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// // // //               final formattedTime = timestamp != null
// // // //                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
// // // //                   : 'Unknown Time';

// // // //               return Card(
// // // //                 color: Colors.orange,
// // // //                 //color: Color.fromARGB(255, 133, 198, 224),
// // // //                 child: Column(
// // // //                   children: [
// // // //                     const SizedBox(
// // // //                       height: 20,
// // // //                     ),
// // // //                     Padding(
// // // //                       padding: const EdgeInsets.only(left: 30),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Padding(
// // // //                             padding: const EdgeInsets.only(left: 25),
// // // //                             child: Text(
// // // //                               textAlign: TextAlign.center,
// // // //                               'Order for ${order['customerName'] ?? 'Unknown'}',
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 18,
// // // //                                 color: Colors.black,
// // // //                                 fontWeight: FontWeight.bold,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Padding(
// // // //                             padding: const EdgeInsets.only(left: 15),
// // // //                             child: Text(
// // // //                               textAlign: TextAlign.center,
// // // //                               'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 18,
// // // //                                 color: Colors.black,
// // // //                                 fontWeight: FontWeight.bold,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Padding(
// // // //                             padding: const EdgeInsets.only(left: 30),
// // // //                             child: Text(
// // // //                               textAlign: TextAlign.center,
// // // //                               'Order Time: $formattedTime',
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 18,
// // // //                                 color: Colors.black,
// // // //                                 fontWeight: FontWeight.bold,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),

// // // //                     ...items.map((item) {
// // // //                       final product =
// // // //                           (item['product'] as Map<String, dynamic>?) ?? {};
// // // //                       final productName = product['name'] as String? ?? '';
// // // //                       final quantity = item['quantity'] as int? ?? 0;
// // // //                       final itemTotalPrice =
// // // //                           item['totalPrice'] as double? ?? 0.0;

// // // //                       return ListTile(
// // // //                         leading: Text(
// // // //                           '$quantity',
// // // //                           style: const TextStyle(
// // // //                             fontSize: 20,
// // // //                             color: Colors.white,
// // // //                             fontWeight: FontWeight.bold,
// // // //                           ),
// // // //                         ),
// // // //                         title: Text(
// // // //                           productName,
// // // //                           maxLines: 2,
// // // //                           overflow: TextOverflow.ellipsis,
// // // //                           style: const TextStyle(
// // // //                             fontSize: 20,
// // // //                             color: Colors.white,
// // // //                             fontWeight: FontWeight.bold,
// // // //                           ),
// // // //                         ),
// // // //                         trailing: Text(
// // // //                           '\$${itemTotalPrice.toStringAsFixed(2)}',
// // // //                           style: const TextStyle(
// // // //                             fontSize: 20,
// // // //                             color: Colors.white,
// // // //                             fontWeight: FontWeight.bold,
// // // //                           ),
// // // //                         ),
// // // //                       );
// // // //                     }).toList(),
// // // //                     const Divider(
// // // //                       color: Colors.white,
// // // //                       indent: 25,
// // // //                       endIndent: 25,
// // // //                       thickness: 3,
// // // //                     ),
// // // //                     Padding(
// // // //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // //                       child: Row(
// // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // //                         children: [
// // // //                           Text(
// // // //                             'Total: \$${order['total'] ?? 0.0}',
// // // //                             style: const TextStyle(
// // // //                               fontSize: 25,
// // // //                               color: Colors.black,
// // // //                               fontWeight: FontWeight.bold,
// // // //                             ),
// // // //                           ),
// // // //                           const SizedBox(width: 16.0),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     // const Divider(
// // // //                     //   color: Colors.orange,
// // // //                     //   indent: 25,
// // // //                     //   endIndent: 25,
// // // //                     //   thickness: 3,
// // // //                     // )
// // // //                   ],
// // // //                 ),
// // // //               );
// // // //             },
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Authentication
// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';

// // // class BillsScreen extends StatefulWidget {
// // //   const BillsScreen({super.key});

// // //   @override
// // //   State<BillsScreen> createState() => _BillsScreenState();
// // // }

// // // class _BillsScreenState extends State<BillsScreen> {
// // //   late String userId; // تخزين معرف المستخدم

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     final User? user =
// // //         FirebaseAuth.instance.currentUser; // الحصول على المستخدم الحالي
// // //     if (user != null) {
// // //       userId = user.uid; // تخزين معرف المستخدم
// // //     } else {
// // //       // إذا لم يكن هناك مستخدم مسجل، يمكنك إعادة توجيهه إلى صفحة تسجيل الدخول أو عرض رسالة
// // //       Navigator.of(context).pushReplacementNamed('/login');
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
// // //           'My Bills',
// // //           style: TextStyle(
// // //             fontSize: 25,
// // //             color: Colors.white,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.orange,
// // //       ),
// // //       body: StreamBuilder(
// // //         stream: FirebaseFirestore.instance
// // //             .collection('cartsUser')
// // //             .where('userId',
// // //                 isEqualTo: userId) // تصفية الفواتير بناءً على معرف المستخدم
// // //             .orderBy('timestamp', descending: true)
// // //             .snapshots(),
// // //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return const Center(
// // //               child: CircularProgressIndicator(
// // //                 color: Colors.orange,
// // //               ),
// // //             );
// // //           }

// // //           if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           }

// // //           final orders = snapshot.data?.docs ?? [];

// // //           return ListView.builder(
// // //             physics: const BouncingScrollPhysics(),
// // //             itemCount: orders.length,
// // //             itemBuilder: (context, index) {
// // //               final order = orders[index].data() as Map<String, dynamic>;
// // //               final documentId = orders[index].id;

// // //               final items = (order['items'] as List<dynamic>?) ?? [];

// // //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// // //               final formattedTime = timestamp != null
// // //                   ? DateFormat('yyyy-MM-dd – hh:mm:ss').format(timestamp)
// // //                   : 'Unknown Time';

// // //               return Card(
// // //                 color: Colors.orange,
// // //                 child: Column(
// // //                   children: [
// // //                     const SizedBox(height: 20),
// // //                     Padding(
// // //                       padding: const EdgeInsets.only(left: 30),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           Padding(
// // //                             padding: const EdgeInsets.only(left: 25),
// // //                             child: Text(
// // //                               textAlign: TextAlign.center,
// // //                               'Order for ${order['customerName'] ?? 'Unknown'}',
// // //                               style: const TextStyle(
// // //                                 fontSize: 18,
// // //                                 color: Colors.black,
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           Padding(
// // //                             padding: const EdgeInsets.only(left: 15),
// // //                             child: Text(
// // //                               textAlign: TextAlign.center,
// // //                               'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
// // //                               style: const TextStyle(
// // //                                 fontSize: 18,
// // //                                 color: Colors.black,
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           Padding(
// // //                             padding: const EdgeInsets.only(left: 30),
// // //                             child: Text(
// // //                               textAlign: TextAlign.center,
// // //                               'Order Time: $formattedTime',
// // //                               style: const TextStyle(
// // //                                 fontSize: 18,
// // //                                 color: Colors.black,
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     ...items.map((item) {
// // //                       final product =
// // //                           (item['product'] as Map<String, dynamic>?) ?? {};
// // //                       final productName = product['name'] as String? ?? '';
// // //                       final quantity = item['quantity'] as int? ?? 0;
// // //                       final itemTotalPrice =
// // //                           item['totalPrice'] as double? ?? 0.0;

// // //                       return ListTile(
// // //                         leading: Text(
// // //                           '$quantity',
// // //                           style: const TextStyle(
// // //                             fontSize: 20,
// // //                             color: Colors.white,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                         title: Text(
// // //                           productName,
// // //                           maxLines: 2,
// // //                           overflow: TextOverflow.ellipsis,
// // //                           style: const TextStyle(
// // //                             fontSize: 20,
// // //                             color: Colors.white,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                         trailing: Text(
// // //                           '\$${itemTotalPrice.toStringAsFixed(2)}',
// // //                           style: const TextStyle(
// // //                             fontSize: 20,
// // //                             color: Colors.white,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                       );
// // //                     }).toList(),
// // //                     const Divider(
// // //                       color: Colors.white,
// // //                       indent: 25,
// // //                       endIndent: 25,
// // //                       thickness: 3,
// // //                     ),
// // //                     Padding(
// // //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //                       child: Row(
// // //                         mainAxisAlignment: MainAxisAlignment.center,
// // //                         children: [
// // //                           Text(
// // //                             'Total: \$${order['total'] ?? 0.0}',
// // //                             style: const TextStyle(
// // //                               fontSize: 25,
// // //                               color: Colors.black,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           const SizedBox(width: 16.0),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class BillsScreen extends StatefulWidget {
// //   const BillsScreen({super.key});

// //   @override
// //   State<BillsScreen> createState() => _BillsScreenState();
// // }

// // class _BillsScreenState extends State<BillsScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Get the current user ID from FirebaseAuth
// //     final userId = FirebaseAuth.instance.currentUser?.uid;

// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(
// //           color: Colors.white,
// //         ),
// //         centerTitle: true,
// //         title: const Text(
// //           'My Bills',
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
// //             .where('userId',
// //                 isEqualTo: userId) // Filter by the current user's ID
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

// //           if (orders.isEmpty) {
// //             return const Center(
// //               child: Text(
// //                 'No bills found',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             );
// //           }

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
// //                 color: Colors.orange,
// //                 child: Column(
// //                   children: [
// //                     const SizedBox(
// //                       height: 20,
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.only(left: 30),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(left: 25),
// //                             child: Text(
// //                               textAlign: TextAlign.center,
// //                               'Order for ${order['customerName'] ?? 'Unknown'}',
// //                               style: const TextStyle(
// //                                 fontSize: 18,
// //                                 color: Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.only(left: 15),
// //                             child: Text(
// //                               textAlign: TextAlign.center,
// //                               'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
// //                               style: const TextStyle(
// //                                 fontSize: 18,
// //                                 color: Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                           Padding(
// //                             padding: const EdgeInsets.only(left: 30),
// //                             child: Text(
// //                               textAlign: TextAlign.center,
// //                               'Order Time: $formattedTime',
// //                               style: const TextStyle(
// //                                 fontSize: 18,
// //                                 color: Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     ...items.map((item) {
// //                       final product =
// //                           (item['product'] as Map<String, dynamic>?) ?? {};
// //                       final productName = product['name'] as String? ?? '';
// //                       final quantity = item['quantity'] as int? ?? 0;
// //                       final itemTotalPrice =
// //                           item['totalPrice'] as double? ?? 0.0;

// //                       return ListTile(
// //                         leading: Text(
// //                           '$quantity',
// //                           style: const TextStyle(
// //                             fontSize: 20,
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         title: Text(
// //                           productName,
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: const TextStyle(
// //                             fontSize: 20,
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         trailing: Text(
// //                           '\$${itemTotalPrice.toStringAsFixed(2)}',
// //                           style: const TextStyle(
// //                             fontSize: 20,
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       );
// //                     }).toList(),
// //                     const Divider(
// //                       color: Colors.white,
// //                       indent: 25,
// //                       endIndent: 25,
// //                       thickness: 3,
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             'Total: \$${order['total'] ?? 0.0}',
// //                             style: const TextStyle(
// //                               fontSize: 25,
// //                               color: Colors.black,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 16.0),
// //                         ],
// //                       ),
// //                     ),
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
// import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// class BillsScreen extends StatefulWidget {
//   @override
//   _BillsScreenState createState() => _BillsScreenState();
// }

// class _BillsScreenState extends State<BillsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   List<DocumentSnapshot> billItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadBills();
//   }

//   Future<void> _loadBills() async {
//     final userId = _auth.currentUser?.uid;
//     if (userId != null) {
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('carts')
//           .get();
//       setState(() {
//         billItems = snapshot.docs;
//       });
//     }
//   }

//   Future<void> _removeBill(String docId) async {
//     final userId = _auth.currentUser?.uid;
//     if (userId != null) {
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('carts')
//           .doc(docId)
//           .delete();
//       setState(() {
//         billItems.removeWhere((doc) => doc.id == docId);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Text(''),
//         centerTitle: true,
//         title: const Text(
//           'My Bills',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.orange,
//       ),
//       body: billItems.isEmpty
//           ? const Center(
//               child: Text(
//                 'No bills found',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : GridView.builder(
//               padding: const EdgeInsets.all(20),
//               physics: const BouncingScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 0.6,
//               ),
//               itemCount: billItems.length,
//               itemBuilder: (context, index) {
//                 final doc = billItems[index];
//                 final data = doc.data() as Map<String, dynamic>;
//                 final billDate = data['billDate'] as String? ?? '';
//                 final totalAmount = data['totalAmount'] as double? ?? 0.0;

//                 return Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Date: $billDate',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             '\$${totalAmount.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _removeBill(doc.id);
//                           customShowSnackBar(
//                             context: context,
//                             content: 'Bill from $billDate is deleted',
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:intl/intl.dart';

class BillsScreen extends StatefulWidget {
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> billItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: const Text(
          'My Bills',
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
                      'No bills found.',
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
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Order for ${order['customerName'] ?? 'Unknown'}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                    leading: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    title: Text(
                                      productName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                      '\$${itemTotalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Delivery Services: \$20',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total: \$${order['total'] ?? 0.0}',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
