// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class OrderScreen extends StatefulWidget {
// //   @override
// //   State<OrderScreen> createState() => _OrderScreenState();
// // }

// // class _OrderScreenState extends State<OrderScreen> {
// //   // Function to handle product deletion
// //   Future<void> deleteItem(String productName) async {
// //     try {
// //       final userId = FirebaseAuth.instance.currentUser?.uid;
// //       if (userId == null) return;

// //       final cartRef =
// //           FirebaseFirestore.instance.collection('carts').doc(userId);
// //       final cartSnapshot = await cartRef.get();
// //       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

// //       if (cartData != null) {
// //         final List<dynamic> items = cartData['items'] ?? [];
// //         items.removeWhere((item) => item['product']['name'] == productName);

// //         await cartRef.update({'items': items});
// //       }
// //     } catch (e) {
// //       print('Error deleting item: $e');
// //     }
// //   }

// //   Future<void> updateItem(
// //     BuildContext context,
// //     String productName,
// //     int currentQuantity,
// //     String currentSize,
// //     List<String> currentExtras,
// //   ) async {
// //     try {
// //       final userId = FirebaseAuth.instance.currentUser?.uid;
// //       if (userId == null) return;

// //       final cartRef =
// //           FirebaseFirestore.instance.collection('carts').doc(userId);
// //       final cartSnapshot = await cartRef.get();
// //       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

// //       if (cartData != null) {
// //         final List<dynamic> items = cartData['items'] ?? [];
// //         final itemIndex =
// //             items.indexWhere((item) => item['product']['name'] == productName);

// //         if (itemIndex != -1) {
// //           int quantity = currentQuantity;
// //           String size = currentSize;
// //           List<String> extras = List.from(currentExtras);

// //           showModalBottomSheet(
// //             context: context,
// //             builder: (context) {
// //               return StatefulBuilder(
// //                 builder: (context, setState) {
// //                   return Container(
// //                     height: 600,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 10),
// //                       child: Column(
// //                         children: [
// //                           Text(
// //                             'Quantity: $quantity',
// //                             style: TextStyle(fontSize: 18),
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               IconButton(
// //                                 icon: Icon(Icons.remove),
// //                                 onPressed: () {
// //                                   if (quantity > 1) {
// //                                     setState(() {
// //                                       quantity--;
// //                                     });
// //                                   }
// //                                 },
// //                               ),
// //                               Text(
// //                                 '$quantity',
// //                                 style: TextStyle(fontSize: 18),
// //                               ),
// //                               IconButton(
// //                                 icon: Icon(Icons.add),
// //                                 onPressed: () {
// //                                   setState(() {
// //                                     quantity++;
// //                                   });
// //                                 },
// //                               ),
// //                             ],
// //                           ),
// //                           Wrap(
// //                             spacing: 5,
// //                             children:
// //                                 ['Small', 'Medium', 'Large'].map((sizeOption) {
// //                               return ChoiceChip(
// //                                 label: Text(sizeOption),
// //                                 selected: size == sizeOption,
// //                                 onSelected: (selected) {
// //                                   setState(() {
// //                                     size = sizeOption;
// //                                   });
// //                                 },
// //                                 selectedColor: Colors.orange,
// //                                 backgroundColor: Colors.grey[200],
// //                               );
// //                             }).toList(),
// //                           ),
// //                           Wrap(
// //                             spacing: 5,
// //                             children: ['Cheese', 'Bacon', 'Lettuce']
// //                                 .map((extraOption) {
// //                               return ChoiceChip(
// //                                 label: Text(extraOption),
// //                                 selected: extras.contains(extraOption),
// //                                 onSelected: (selected) {
// //                                   setState(() {
// //                                     if (selected) {
// //                                       extras.add(extraOption);
// //                                     } else {
// //                                       extras.remove(extraOption);
// //                                     }
// //                                   });
// //                                 },
// //                                 selectedColor: Colors.orange,
// //                                 backgroundColor: Colors.grey[200],
// //                               );
// //                             }).toList(),
// //                           ),
// //                           ElevatedButton(
// //                             onPressed: () async {
// //                               // Update items with new values

// //                               // setState(() {
// //                               //   double price =
// //                               //       (items[itemIndex]['price'] as double?) ??
// //                               //           0.0;
// //                               //   items[itemIndex]['quantity'] = quantity;
// //                               //   items[itemIndex]['size'] = size;
// //                               //   items[itemIndex]['extras'] = extras;
// //                               //   items[itemIndex]['totalPrice'] =
// //                               //       price * quantity;
// //                               // });

// //                               setState(() {
// //                                 double price = (items[itemIndex]['product']
// //                                         ['price'] as double?) ??
// //                                     0.0;
// //                                 items[itemIndex]['quantity'] = quantity;
// //                                 items[itemIndex]['size'] = size;
// //                                 items[itemIndex]['extras'] = extras;
// //                                 items[itemIndex]['totalPrice'] =
// //                                     price * quantity;
// //                               });

// //                               await cartRef.update({'items': items});
// //                               Navigator.pop(context);
// //                             },
// //                             child: Text('Update'),
// //                             style: ElevatedButton.styleFrom(
// //                                 // primary: Colors.orange
// //                                 ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           );
// //         }
// //       }
// //     } catch (e) {
// //       print('Error updating item: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double deliveryPrice = 20;

// //     return Scaffold(
// //       backgroundColor: Color(0xffF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: Color(0xffF4F4F4),
// //         centerTitle: true,
// //         title: const Text(
// //           'Check Out',
// //           style: TextStyle(
// //             color: Colors.orange,
// //             fontSize: 27,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: StreamBuilder<DocumentSnapshot>(
// //         stream: FirebaseFirestore.instance
// //             .collection('carts')
// //             .doc(FirebaseAuth.instance.currentUser?.uid)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }

// //           if (!snapshot.hasData || !snapshot.data!.exists) {
// //             return Center(child: Text('No items in cart.'));
// //           }

// //           final cartData = snapshot.data!.data() as Map<String, dynamic>;
// //           final items = cartData['items'] as List<dynamic>? ?? [];

// //           double totalPrice = 0;
// //           for (var item in items) {
// //             final double itemPrice = item['totalPrice'] as double? ?? 0.0;
// //             totalPrice += itemPrice;
// //           }

// //           // Add delivery price to total price
// //           if (totalPrice > 0) {
// //             totalPrice += deliveryPrice;
// //           }

// //           return Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 20,
// //                   vertical: 10,
// //                 ),
// //                 child: Text(
// //                   'Your Order',
// //                   style: TextStyle(
// //                     color: Colors.orange,
// //                     fontSize: 25,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: ListView.builder(
// //                   itemCount: items.length,
// //                   itemBuilder: (context, index) {
// //                     final item = items[index] as Map<String, dynamic>;
// //                     final product =
// //                         item['product'] as Map<String, dynamic>? ?? {};

// //                     final productName = product['name'] as String? ?? '';
// //                     final productImage = product['image'] as String? ?? '';
// //                     final quantity = item['quantity'] as int? ?? 0;
// //                     final size = item['size'] as String? ?? '';
// //                     final extras = item['extras'] as List<dynamic>? ?? [];
// //                     final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

// //                     return Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 10),
// //                       child: Dismissible(
// //                         key: UniqueKey(),
// //                         direction: DismissDirection.endToStart,
// //                         background: Container(
// //                           alignment: Alignment.centerRight,
// //                           padding: EdgeInsets.symmetric(horizontal: 20),
// //                           color: Colors.red,
// //                           child: Icon(
// //                             Icons.delete,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         confirmDismiss: (direction) async {
// //                           return await showDialog(
// //                             context: context,
// //                             builder: (BuildContext context) {
// //                               return AlertDialog(
// //                                 title: Text("Confirm Deletion"),
// //                                 content: Text(
// //                                     "Are you sure you want to delete this item?"),
// //                                 actions: <Widget>[
// //                                   TextButton(
// //                                     onPressed: () =>
// //                                         Navigator.of(context).pop(false),
// //                                     child: Text("Cancel"),
// //                                   ),
// //                                   TextButton(
// //                                     onPressed: () =>
// //                                         Navigator.of(context).pop(true),
// //                                     child: Text("Delete"),
// //                                   ),
// //                                 ],
// //                               );
// //                             },
// //                           );
// //                         },
// //                         onDismissed: (direction) {
// //                           setState(() {
// //                             deleteItem(productName);
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(content: Text("$productName deleted")),
// //                             );
// //                           });
// //                         },
// //                         child: Card(
// //                           elevation: 5,
// //                           color: Colors.white,
// //                           child: ListTile(
// //                             leading: Container(
// //                               height: 70,
// //                               width: 80,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(
// //                                     10), // Adjust the radius as needed
// //                                 border: Border.all(
// //                                     color: Colors.white,
// //                                     width:
// //                                         2), // Optional: Add a border if desired
// //                               ),
// //                               child: productImage.startsWith('http')
// //                                   ? ClipRRect(
// //                                       borderRadius: BorderRadius.circular(
// //                                           10), // Ensure the border radius matches
// //                                       child: Image.network(
// //                                         productImage,
// //                                         height: 50,
// //                                         width: 50,
// //                                         fit: BoxFit.contain,
// //                                       ),
// //                                     )
// //                                   : Center(
// //                                       child: Icon(
// //                                         Icons.image,
// //                                         size: 120,
// //                                         color: Colors.black,
// //                                       ),
// //                                     ),
// //                             ),
// //                             title: Text(
// //                               productName,
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.orange,
// //                               ),
// //                             ),
// //                             subtitle: Text(
// //                               'Quantity: $quantity\n\$${itemTotalPrice.toStringAsFixed(2)}',
// //                               style: TextStyle(
// //                                 color: Colors.black,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             // subtitle: Text(
// //                             //   'Quantity: $quantity\nSize: $size\nExtras: ${extras.join(", ")}\nPrice: \$${itemTotalPrice.toStringAsFixed(2)}',
// //                             // ),
// //                             // trailing: Row(
// //                             //   mainAxisSize: MainAxisSize.min,
// //                             //   children: [
// //                             //     IconButton(
// //                             //       icon: Icon(Icons.edit),
// //                             //       onPressed: () {
// //                             //         updateItem(context, productName, quantity,
// //                             //             size, extras.cast<String>());
// //                             //       },
// //                             //     ),
// //                             //   ],
// //                             // ),

// //                             trailing: Row(
// //                                       children: [
// //                                         Padding(
// //                                           padding:
// //                                               const EdgeInsets.only(left: 10),
// //                                           child: Text(
// //                                             'Quantity',
// //                                             style: TextStyle(
// //                                               fontSize: 20,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         const SizedBox(
// //                                           width: 140,
// //                                         ),
// //                                         InkWell(
// //                                           onTap: () {
// //                                             setState(() {
// //                                               if (counter > 0) {
// //                                                 counter--;
// //                                                 calculateTotalPrice(price);
// //                                               }
// //                                             });
// //                                           },
// //                                           child: Container(
// //                                             color: Colors.orange,
// //                                             width: 30,
// //                                             height: 30,
// //                                             child: const Align(
// //                                               alignment: Alignment.center,
// //                                               child: Text(
// //                                                 '-',
// //                                                 style: TextStyle(
// //                                                     color: Colors.white,
// //                                                     fontSize: 20,
// //                                                     fontWeight:
// //                                                         FontWeight.bold),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         const SizedBox(
// //                                           width: 10,
// //                                         ),
// //                                         Text(
// //                                           '$counter',
// //                                           style: const TextStyle(
// //                                             fontSize: 20,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         const SizedBox(
// //                                           width: 10,
// //                                         ),
// //                                         InkWell(
// //                                           onTap: () {
// //                                             setState(() {
// //                                               counter++;
// //                                               calculateTotalPrice(price);
// //                                             });
// //                                           },
// //                                           child: Container(
// //                                             color: Colors.orange,
// //                                             width: 30,
// //                                             height: 30,
// //                                             child: const Align(
// //                                               alignment: Alignment.center,
// //                                               child: Text(
// //                                                 '+',
// //                                                 style: TextStyle(
// //                                                     color: Colors.white,
// //                                                     fontSize: 20,
// //                                                     fontWeight:
// //                                                         FontWeight.bold),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   children: [
// //                     Divider(
// //                       color: Colors.orange,
// //                       thickness: 2,
// //                       indent: 20,
// //                       endIndent: 20,
// //                     ),
// //                     const SizedBox(
// //                       height: 10,
// //                     ),
// //                     Row(
// //                       children: [
// //                         Text(
// //                           'Delivery:',
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Spacer(),
// //                         Text(
// //                           '\$${deliveryPrice}',
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.orange,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       children: [
// //                         Text(
// //                           'Total:',
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Spacer(),
// //                         Text(
// //                           '\$${totalPrice.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.orange,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class ProductFoods {
// //   final String name;
// //   final double price;
// //   final String image;

// //   ProductFoods(this.name, this.price, this.image);

// //   // Convert ProductFoods to a Map for Firestore
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'name': name,
// //       'price': price,
// //       'image': image,
// //     };
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class OrderScreen extends StatefulWidget {
// //   @override
// //   State<OrderScreen> createState() => _OrderScreenState();
// // }

// // class _OrderScreenState extends State<OrderScreen> {
// //   // Method to handle product deletion
// //   Future<void> deleteItem(String productName) async {
// //     try {
// //       final userId = FirebaseAuth.instance.currentUser?.uid;
// //       if (userId == null) return;

// //       final cartRef =
// //           FirebaseFirestore.instance.collection('carts').doc(userId);
// //       final cartSnapshot = await cartRef.get();
// //       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

// //       if (cartData != null) {
// //         final List<dynamic> items = cartData['items'] ?? [];
// //         items.removeWhere((item) => item['product']['name'] == productName);

// //         await cartRef.update({'items': items});
// //       }
// //     } catch (e) {
// //       print('Error deleting item: $e');
// //     }
// //   }

// //   // Method to update the item
// //   Future<void> updateItem(
// //     String productName,
// //     int quantity,
// //     String size,
// //     List<String> extras,
// //   ) async {
// //     try {
// //       final userId = FirebaseAuth.instance.currentUser?.uid;
// //       if (userId == null) return;

// //       final cartRef =
// //           FirebaseFirestore.instance.collection('carts').doc(userId);
// //       final cartSnapshot = await cartRef.get();
// //       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

// //       if (cartData != null) {
// //         final List<dynamic> items = cartData['items'] ?? [];
// //         final itemIndex =
// //             items.indexWhere((item) => item['product']['name'] == productName);

// //         if (itemIndex != -1) {
// //           setState(() {
// //             double price =
// //                 (items[itemIndex]['product']['price'] as double?) ?? 0.0;
// //             items[itemIndex]['quantity'] = quantity;
// //             items[itemIndex]['size'] = size;
// //             items[itemIndex]['extras'] = extras;
// //             items[itemIndex]['totalPrice'] = price * quantity;
// //           });

// //           await cartRef.update({'items': items});
// //         }
// //       }
// //     } catch (e) {
// //       print('Error updating item: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double deliveryPrice = 20;

// //     return Scaffold(
// //       backgroundColor: Color(0xffF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: Color(0xffF4F4F4),
// //         centerTitle: true,
// //         title: const Text(
// //           'Check Out',
// //           style: TextStyle(
// //             color: Colors.orange,
// //             fontSize: 27,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: StreamBuilder<DocumentSnapshot>(
// //         stream: FirebaseFirestore.instance
// //             .collection('carts')
// //             .doc(FirebaseAuth.instance.currentUser?.uid)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }

// //           if (!snapshot.hasData || !snapshot.data!.exists) {
// //             return Center(child: Text('No items in cart.'));
// //           }

// //           final cartData = snapshot.data!.data() as Map<String, dynamic>;
// //           final items = cartData['items'] as List<dynamic>? ?? [];

// //           double totalPrice = 0;
// //           for (var item in items) {
// //             final double itemPrice = item['totalPrice'] as double? ?? 0.0;
// //             totalPrice += itemPrice;
// //           }

// //           // Add delivery price to total price
// //           if (totalPrice > 0) {
// //             totalPrice += deliveryPrice;
// //           }

// //           return Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 20,
// //                   vertical: 10,
// //                 ),
// //                 child: Text(
// //                   'Your Order',
// //                   style: TextStyle(
// //                     color: Colors.orange,
// //                     fontSize: 25,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: ListView.builder(
// //                   itemCount: items.length,
// //                   itemBuilder: (context, index) {
// //                     final item = items[index] as Map<String, dynamic>;
// //                     final product =
// //                         item['product'] as Map<String, dynamic>? ?? {};

// //                     final productName = product['name'] as String? ?? '';
// //                     final productImage = product['image'] as String? ?? '';
// //                     int quantity = item['quantity'] as int? ?? 0;
// //                     final size = item['size'] as String? ?? '';
// //                     final extras = item['extras'] as List<dynamic>? ?? [];
// //                     final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

// //                     return Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 10),
// //                       child: Dismissible(
// //                         key: UniqueKey(),
// //                         direction: DismissDirection.endToStart,
// //                         background: Container(
// //                           alignment: Alignment.centerRight,
// //                           padding: EdgeInsets.symmetric(horizontal: 20),
// //                           color: Colors.red,
// //                           child: Icon(
// //                             Icons.delete,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         confirmDismiss: (direction) async {
// //                           return await showDialog(
// //                             context: context,
// //                             builder: (BuildContext context) {
// //                               return AlertDialog(
// //                                 title: Text("Confirm Deletion"),
// //                                 content: Text(
// //                                     "Are you sure you want to delete this item?"),
// //                                 actions: <Widget>[
// //                                   TextButton(
// //                                     onPressed: () =>
// //                                         Navigator.of(context).pop(false),
// //                                     child: Text("Cancel"),
// //                                   ),
// //                                   TextButton(
// //                                     onPressed: () =>
// //                                         Navigator.of(context).pop(true),
// //                                     child: Text("Delete"),
// //                                   ),
// //                                 ],
// //                               );
// //                             },
// //                           );
// //                         },
// //                         onDismissed: (direction) {
// //                           setState(() {
// //                             deleteItem(productName);
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(content: Text("$productName deleted")),
// //                             );
// //                           });
// //                         },
// //                         child: Card(
// //                           elevation: 5,
// //                           color: Colors.white,
// //                           child: ListTile(
// //                             leading: Container(
// //                               height: 70,
// //                               width: 80,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(
// //                                     10), // Adjust the radius as needed
// //                                 border: Border.all(
// //                                     color: Colors.white,
// //                                     width:
// //                                         2), // Optional: Add a border if desired
// //                               ),
// //                               child: productImage.startsWith('http')
// //                                   ? ClipRRect(
// //                                       borderRadius: BorderRadius.circular(
// //                                           10), // Ensure the border radius matches
// //                                       child: Image.network(
// //                                         productImage,
// //                                         height: 50,
// //                                         width: 50,
// //                                         fit: BoxFit.contain,
// //                                       ),
// //                                     )
// //                                   : Center(
// //                                       child: Icon(
// //                                         Icons.image,
// //                                         size: 120,
// //                                         color: Colors.black,
// //                                       ),
// //                                     ),
// //                             ),
// //                             title: Text(
// //                               productName,
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.orange,
// //                               ),
// //                             ),
// //                             subtitle:
// //                                 Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
// //                             // subtitle: Row(
// //                             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             //   children: [
// //                             //     Text(
// //                             //       'Size: $size\nExtras: ${extras.join(', ')}',
// //                             //       style: TextStyle(
// //                             //         color: Colors.black,
// //                             //         fontWeight: FontWeight.bold,
// //                             //       ),
// //                             //     ),
// //                             //     Text(
// //                             //       '\$${itemTotalPrice.toStringAsFixed(2)}',
// //                             //       style: TextStyle(
// //                             //         fontWeight: FontWeight.bold,
// //                             //       ),
// //                             //     ),
// //                             //   ],
// //                             // ),
// //                             trailing: Row(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: [
// //                                 IconButton(
// //                                   icon: Icon(Icons.remove),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       if (quantity > 1) {
// //                                         quantity--;
// //                                         updateItem(
// //                                           productName,
// //                                           quantity,
// //                                           size,
// //                                           extras.cast<String>(),
// //                                         );
// //                                       }
// //                                     });
// //                                   },
// //                                 ),
// //                                 Text(
// //                                   '$quantity',
// //                                   style: TextStyle(
// //                                     fontSize: 20,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                                 IconButton(
// //                                   icon: Icon(Icons.add),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       quantity++;
// //                                     });
// //                                     updateItem(
// //                                       productName,
// //                                       quantity,
// //                                       size,
// //                                       extras.cast<String>(),
// //                                     );
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     SizedBox(height: 10),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Subtotal',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           '\$${totalPrice.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 10),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Delivery Fee',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           '\$${deliveryPrice.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 10),
// //                     Divider(
// //                       color: Colors.orange,
// //                       thickness: 2,
// //                       indent: 20,
// //                       endIndent: 20,
// //                     ),
// //                     SizedBox(height: 10),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Total',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           '\$${(totalPrice + deliveryPrice).toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class ProductFoods {
// //   final String name;
// //   final double price;
// //   final String image;

// //   ProductFoods(this.name, this.price, this.image);

// //   // Convert ProductFoods to a Map for Firestore
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'name': name,
// //       'price': price,
// //       'image': image,
// //     };
// //   }
// // }

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final StreamController<void> _updateController = StreamController<void>();

//   @override
//   void dispose() {
//     _updateController.close();
//     super.dispose();
//   }

//   Future<void> deleteItem(String productName) async {
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId == null) return;

//       final cartRef =
//           FirebaseFirestore.instance.collection('carts').doc(userId);
//       final cartSnapshot = await cartRef.get();
//       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

//       if (cartData != null) {
//         final List<dynamic> items = cartData['items'] ?? [];
//         items.removeWhere((item) => item['product']['name'] == productName);

//         await cartRef.update({'items': items});
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("$productName deleted")),
//         );
//       }
//     } catch (e) {
//       print('Error deleting item: $e');
//     }
//   }

//   Future<void> updateItem(
//     String productName,
//     int quantity,
//     String size,
//     List<String> extras,
//   ) async {
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId == null) return;

//       final cartRef =
//           FirebaseFirestore.instance.collection('carts').doc(userId);
//       final cartSnapshot = await cartRef.get();
//       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

//       if (cartData != null) {
//         final List<dynamic> items = cartData['items'] ?? [];
//         final itemIndex =
//             items.indexWhere((item) => item['product']['name'] == productName);

//         if (itemIndex != -1) {
//           double price =
//               (items[itemIndex]['product']['price'] as double?) ?? 0.0;
//           items[itemIndex]['quantity'] = quantity;
//           items[itemIndex]['size'] = size;
//           items[itemIndex]['extras'] = extras;
//           items[itemIndex]['totalPrice'] = price * quantity;

//           await cartRef.update({'items': items});
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Item updated")),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating item: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double deliveryPrice = 20;

//     return Scaffold(
//       backgroundColor: Color(0xffF4F4F4),
//       appBar: AppBar(
//         backgroundColor: Color(0xffF4F4F4),
//         centerTitle: true,
//         title: const Text(
//           'Check Out',
//           style: TextStyle(
//             color: Colors.orange,
//             fontSize: 27,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('carts')
//             .doc(FirebaseAuth.instance.currentUser?.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('No items in cart.'));
//           }

//           final cartData = snapshot.data!.data() as Map<String, dynamic>;
//           final items = cartData['items'] as List<dynamic>? ?? [];

//           double totalPrice = 0;
//           for (var item in items) {
//             final double itemPrice = item['totalPrice'] as double? ?? 0.0;
//             totalPrice += itemPrice;
//           }

//           // Add delivery price to total price
//           if (totalPrice > 0) {
//             totalPrice += deliveryPrice;
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 10,
//                 ),
//                 child: Text(
//                   'Your Order',
//                   style: TextStyle(
//                     color: Colors.orange,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index] as Map<String, dynamic>;
//                     final product =
//                         item['product'] as Map<String, dynamic>? ?? {};

//                     final productName = product['name'] as String? ?? '';
//                     final productImage = product['image'] as String? ?? '';
//                     int quantity = item['quantity'] as int? ?? 0;
//                     final size = item['size'] as String? ?? '';
//                     final extras = item['extras'] as List<dynamic>? ?? [];
//                     final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       child: Dismissible(
//                         key: UniqueKey(),
//                         direction: DismissDirection.endToStart,
//                         background: Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           color: Colors.red,
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                         confirmDismiss: (direction) async {
//                           return await showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Confirm Deletion"),
//                                 content: Text(
//                                     "Are you sure you want to delete this item?"),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.of(context).pop(false),
//                                     child: Text("Cancel"),
//                                   ),
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.of(context).pop(true),
//                                     child: Text("Delete"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         onDismissed: (direction) {
//                           deleteItem(productName);
//                         },
//                         child: Card(
//                           elevation: 5,
//                           color: Colors.white,
//                           child: ListTile(
//                             leading: Container(
//                               height: 70,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Adjust the radius as needed
//                                 border: Border.all(
//                                     color: Colors.white,
//                                     width:
//                                         2), // Optional: Add a border if desired
//                               ),
//                               child: productImage.startsWith('http')
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(
//                                           10), // Ensure the border radius matches
//                                       child: Image.network(
//                                         productImage,
//                                         height: 50,
//                                         width: 50,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     )
//                                   : Center(
//                                       child: Icon(
//                                         Icons.image,
//                                         size: 120,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                             ),
//                             title: Text(
//                               productName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             subtitle:
//                                 Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.remove),
//                                   onPressed: () {
//                                     if (quantity > 1) {
//                                       quantity--;
//                                       updateItem(
//                                         productName,
//                                         quantity,
//                                         size,
//                                         extras.cast<String>(),
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 Text(
//                                   '$quantity',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.add),
//                                   onPressed: () {
//                                     quantity++;
//                                     updateItem(
//                                       productName,
//                                       quantity,
//                                       size,
//                                       extras.cast<String>(),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Subtotal',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         Text(
//                           '\$${(totalPrice - deliveryPrice).toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Delivery Price',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         Text(
//                           '\$${deliveryPrice.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Divider(),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Price',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '\$${totalPrice.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle checkout
//                         },
//                         child: Text(
//                           'Checkout',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ProductFoods {
//   final String name;
//   final double price;
//   final String image;

//   ProductFoods(this.name, this.price, this.image);

//   // Convert ProductFoods to a Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'price': price,
//       'image': image,
//     };
//   }
// }

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final StreamController<void> _updateController = StreamController<void>();

//   @override
//   void dispose() {
//     _updateController.close();
//     super.dispose();
//   }

//   Future<void> deleteItem(String productName) async {
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId == null) return;

//       final cartRef =
//           FirebaseFirestore.instance.collection('carts').doc(userId);
//       final cartSnapshot = await cartRef.get();
//       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

//       if (cartData != null) {
//         final List<dynamic> items = cartData['items'] ?? [];
//         items.removeWhere((item) => item['product']['name'] == productName);

//         await cartRef.update({'items': items});
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("$productName deleted")),
//         );
//       }
//     } catch (e) {
//       print('Error deleting item: $e');
//     }
//   }

//   Future<void> updateItem(
//     String productName,
//     int quantity,
//     String size,
//     List<String> extras,
//     double extrasPrice,
//   ) async {
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId == null) return;

//       final cartRef =
//           FirebaseFirestore.instance.collection('carts').doc(userId);
//       final cartSnapshot = await cartRef.get();
//       final cartData = cartSnapshot.data() as Map<String, dynamic>?;

//       if (cartData != null) {
//         final List<dynamic> items = cartData['items'] ?? [];
//         final itemIndex =
//             items.indexWhere((item) => item['product']['name'] == productName);

//         if (itemIndex != -1) {
//           double price =
//               (items[itemIndex]['product']['price'] as double?) ?? 0.0;
//           items[itemIndex]['quantity'] = quantity;
//           items[itemIndex]['size'] = size;
//           items[itemIndex]['extras'] = extras;
//           items[itemIndex]['totalPrice'] = (price + extrasPrice) * quantity;

//           await cartRef.update({'items': items});
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Item updated")),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating item: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double deliveryPrice = 20;

//     return Scaffold(
//       backgroundColor: Color(0xffF4F4F4),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushNamed(context, 'userScreen');
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.orange,
//           ),
//         ),
//         backgroundColor: Color(0xffF4F4F4),
//         centerTitle: true,
//         title: const Text(
//           'Check Out',
//           style: TextStyle(
//             color: Colors.orange,
//             fontSize: 27,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('carts')
//             .doc(FirebaseAuth.instance.currentUser?.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('No items in cart.'));
//           }

//           final cartData = snapshot.data!.data() as Map<String, dynamic>;
//           final items = cartData['items'] as List<dynamic>? ?? [];

//           double totalPrice = 0;
//           for (var item in items) {
//             final double itemPrice = item['totalPrice'] as double? ?? 0.0;
//             totalPrice += itemPrice;
//           }

//           // Add delivery price to total price
//           if (totalPrice > 0) {
//             totalPrice += deliveryPrice;
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 10,
//                 ),
//                 child: Text(
//                   'Your Order',
//                   style: TextStyle(
//                     color: Colors.orange,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index] as Map<String, dynamic>;
//                     final product =
//                         item['product'] as Map<String, dynamic>? ?? {};

//                     final productName = product['name'] as String? ?? '';
//                     final productImage = product['image'] as String? ?? '';
//                     int quantity = item['quantity'] as int? ?? 0;
//                     final size = item['size'] as String? ?? '';
//                     final extras = item['extras'] as List<dynamic>? ?? [];
//                     final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

//                     double extrasPrice = 0.0;
//                     // Calculate the extras price
//                     for (var extra in extras) {
//                       // Ensure `extra` contains `price` field and convert it to double
//                       double price = 0.0;
//                       if (extra is Map<String, dynamic>) {
//                         final priceValue = extra['price'];
//                         if (priceValue is String) {
//                           price = double.tryParse(priceValue) ?? 0.0;
//                         } else if (priceValue is double) {
//                           price = priceValue;
//                         }
//                       }
//                       extrasPrice += price;
//                     }

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       child: Dismissible(
//                         key: UniqueKey(),
//                         direction: DismissDirection.endToStart,
//                         background: Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           color: Colors.red,
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                         confirmDismiss: (direction) async {
//                           return await showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Confirm Deletion"),
//                                 content: Text(
//                                     "Are you sure you want to delete this item?"),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.of(context).pop(false),
//                                     child: Text("Cancel"),
//                                   ),
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.of(context).pop(true),
//                                     child: Text("Delete"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         onDismissed: (direction) {
//                           deleteItem(productName);
//                         },
//                         child: Card(
//                           elevation: 5,
//                           color: Colors.white,
//                           child: ListTile(
//                             leading: Container(
//                               height: 70,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Adjust the radius as needed
//                                 border: Border.all(
//                                     color: Colors.white,
//                                     width:
//                                         2), // Optional: Add a border if desired
//                               ),
//                               child: productImage.startsWith('http')
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(
//                                           10), // Ensure the border radius matches
//                                       child: Image.network(
//                                         productImage,
//                                         height: 50,
//                                         width: 50,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     )
//                                   : Center(
//                                       child: Icon(
//                                         Icons.image,
//                                         size: 120,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                             ),
//                             title: Text(
//                               productName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Size: $size'),
//                                 SizedBox(height: 5),
//                                 Text('Extras: ${extras.join(', ')}'),
//                                 SizedBox(height: 5),
//                                 Text('\$${itemTotalPrice.toStringAsFixed(2)}'),
//                               ],
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.remove),
//                                   onPressed: () {
//                                     if (quantity > 1) {
//                                       quantity--;
//                                       updateItem(
//                                         productName,
//                                         quantity,
//                                         size,
//                                         extras.cast<String>(),
//                                         extrasPrice,
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 Text('$quantity'),
//                                 IconButton(
//                                   icon: Icon(Icons.add),
//                                   onPressed: () {
//                                     quantity++;
//                                     updateItem(
//                                       productName,
//                                       quantity,
//                                       size,
//                                       extras.cast<String>(),
//                                       extrasPrice,
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Total Price: \$${totalPrice.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Delivery Price: \$${deliveryPrice.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Place order logic here
//                         },
//                         child: Text('Place Order'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ProductFoods {
//   final String name;
//   final double price;
//   final String image;

//   ProductFoods(this.name, this.price, this.image);

//   // Convert ProductFoods to a Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'price': price,
//       'image': image,
//     };
//   }
// }

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services.dart';
import 'package:food_ordering_app/widgets/checkout_button.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final StreamController<void> _updateController = StreamController<void>();

  // Location location = Location();

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
            backgroundColor: Color(0xffF4F4F4),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'userScreen');
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.orange,
                ),
              ),
              backgroundColor: Color(0xffF4F4F4),
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
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('No items in cart.'));
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
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
                          final product =
                              item['product'] as Map<String, dynamic>? ?? {};

                          final itemId = item['id'] as String? ?? '';
                          final productName = product['name'] as String? ?? '';
                          final productImage =
                              product['image'] as String? ?? '';
                          int quantity = item['quantity'] as int? ?? 0;
                          final size = item['size'] as String? ?? '';
                          final itemTotalPrice =
                              item['totalPrice'] as double? ?? 0.0;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirm Deletion"),
                                      content: Text(
                                        "Are you sure you want to delete $productName?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.orange,
                                              ),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
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
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                deleteItem(itemId, productName);
                              },
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                child: ListTile(
                                  leading: Container(
                                    height: 70,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the radius as needed
                                      border: Border.all(
                                          color: Colors.white,
                                          width:
                                              2), // Optional: Add a border if desired
                                    ),
                                    child: productImage.startsWith('http')
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10), // Ensure the border radius matches
                                            child: Image.network(
                                              productImage,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.image,
                                              size: 120,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                  title: Text(
                                    productName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Size: $size'),
                                      SizedBox(height: 5),
                                      Text(
                                          '\$${itemTotalPrice.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (quantity > 1) {
                                            quantity--;
                                            updateItem(
                                              itemId,
                                              quantity,
                                              size, // مرر الحجم المختار هنا
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '$quantity',
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (quantity >= 1) {
                                            quantity++;
                                            updateItem(
                                              itemId,
                                              quantity,
                                              size, // مرر الحجم المختار هنا
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // IconButton(
                                      //   icon: Icon(Icons.add),
                                      //   onPressed: () {
                                      //     quantity++;
                                      //     updateItem(
                                      //       productName,
                                      //       quantity,
                                      //       size, // مرر الحجم المختار هنا
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),

                                  // trailing: Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.remove),
                                  //       onPressed: () {
                                  //         if (quantity > 1) {
                                  //           quantity--;
                                  //           updateItem(
                                  //             productName,
                                  //             quantity,
                                  //             size,
                                  //           );
                                  //         }
                                  //       },
                                  //     ),
                                  //     Text('$quantity'),
                                  //     IconButton(
                                  //       icon: Icon(Icons.add),
                                  //       onPressed: () {
                                  //         quantity++;
                                  //         updateItem(
                                  //           productName,
                                  //           quantity,
                                  //           size,
                                  //         );
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
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
                              Text(
                                'Delivery services:',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${deliveryPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Total : ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CheckoutButton(
                            items: items,
                            deliveryPrice: deliveryPrice,
                            total: totalPrice,
                            customerName: authService.userName != null
                                ? '${authService.userName}'
                                : 'sadsa',
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}

class ProductFoods {
  final String name;
  final double price;
  final String image;

  ProductFoods(this.name, this.price, this.image);

  // Convert ProductFoods to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
    };
  }
}
