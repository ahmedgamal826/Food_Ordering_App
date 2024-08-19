// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
// import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// class Product {
//   final String name;
//   final double price;

//   Product(this.name, this.price);
// }

// class FoodList extends StatefulWidget {
//   final String collectionName;
//   final String searchQuery;
//   final String foodName;
//   final String foodDetailsRoute;

//   FoodList({
//     super.key,
//     required this.collectionName,
//     required this.searchQuery,
//     required this.foodName,
//     required this.foodDetailsRoute,
//   });

//   @override
//   State<FoodList> createState() => _FoodListState();
// }

// class _FoodListState extends State<FoodList> {
//   int counter = 1;

//   String selectedValue = 'option';

//   final List<Product> products = [
//     Product('Chicken(\$2.00)', 2.00),
//     Product('Beef(\$3.00)', 3.00),
//     Product('Paprika(\$2.00)', 2.00),
//     Product('Cheese(\$2.00)', 2.00),
//     Product('Pickle(\$2.00)', 2.00),
//     Product('Angus Beef(\$5.00)', 5.00),
//     Product('Potato(\$2.00)', 2.00),
//     Product('Broccoli(\$2.00)', 2.00),
//     Product('Onion(\$2.00)', 2.00),
//     Product('Fries(\$4.00)', 4.00),
//   ];

//   final Map<Product, double> selectedProducts = {};
//   double _totalPrice = 0.0;

//   void getTotalPrice() {
//     double totalPrice = 0.0;
//     for (var entry in selectedProducts.entries) {
//       final product = entry.key;
//       final quantity = entry.value;
//       totalPrice += product.price * quantity;
//     }
//     setState(() {
//       _totalPrice = totalPrice;
//     });
//   }

//   bool isAdmin = false;

//   @override
//   void initState() {
//     super.initState();
//     checkUserRole();
//   }

//   Future<void> checkUserRole() async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       DocumentSnapshot adminDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (adminDoc.exists) {
//         String role = adminDoc.get('rool'); // Fix the field name here
//         setState(() {
//           isAdmin = role == 'admin';
//         });
//       } else {
//         setState(() {
//           isAdmin = false;
//         });
//       }
//     } else {
//       setState(() {
//         isAdmin = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference foodRef =
//         FirebaseFirestore.instance.collection(widget.collectionName);

//     final String lowercaseQuery = widget.searchQuery.toLowerCase();

//     // Update all documents to ensure they have 'name_lowercase'
//     updateAllDocuments(foodRef);

//     // Determine the stream based on whether there is a search query
//     final Stream<QuerySnapshot> stream = widget.searchQuery.isNotEmpty
//         ? foodRef
//             .where('name_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
//             .where('name_lowercase',
//                 isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
//             .snapshots()
//         : foodRef.orderBy('timestamp', descending: true).snapshots();

//     return StreamBuilder<QuerySnapshot>(
//       stream: stream,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.orange,
//             ),
//           );
//         }

//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Something went wrong: ${snapshot.error}',
//               style: TextStyle(fontSize: 16, color: Colors.red),
//             ),
//           );
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Text(
//               widget.searchQuery.isNotEmpty
//                   ? 'No results found for "${widget.searchQuery}".'
//                   : 'No items available.',
//               style: TextStyle(fontSize: 16, color: Colors.orange),
//             ),
//           );
//         }

//         final documents = snapshot.data!.docs;

//         final String categoryName =
//             (widget.collectionName == 'tea category') ? 'Drinks' : 'Foods';

//         return ListView(
//           padding: const EdgeInsets.all(20),
//           physics: const BouncingScrollPhysics(),
//           children: [
//             const Text(
//               "What is your",
//               style: TextStyle(
//                 fontSize: 30,
//               ),
//             ),
//             Text(
//               'favourite ${widget.foodName}?',
//               style: const TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 final doc = documents[index];
//                 final data = doc.data() as Map<String, dynamic>;
//                 final imageUrl = data['image'] as String? ?? '';
//                 final name = data['name'] as String? ?? '';
//                 final price = data['price'];
//                 return InkWell(
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return StatefulBuilder(builder:
//                             (BuildContext context, StateSetter setState) {
//                           return Container(
//                             height: 500,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       imageUrl.startsWith('http')
//                                           ? Image.network(
//                                               height: 120,
//                                               width: 120,
//                                               fit: BoxFit.contain,
//                                               imageUrl,
//                                               //fit: BoxFit.cover,
//                                             )
//                                           : Icon(
//                                               Icons.image,
//                                               size: 120,
//                                               color: Colors.black,
//                                             ),
//                                       const SizedBox(
//                                         width: 20,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Container(
//                                             constraints: BoxConstraints(
//                                               maxWidth: 220,
//                                             ),
//                                             child: Text(
//                                               name,
//                                               softWrap: true,
//                                               overflow: TextOverflow.clip,
//                                               style: TextStyle(
//                                                 fontSize: 25,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(height: 5),
//                                           Text(
//                                             '⭐⭐⭐⭐⭐',
//                                             style: TextStyle(fontSize: 13),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(
//                                                 '\$$price',
//                                                 style: TextStyle(
//                                                   fontSize: 23,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.34,
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons.favorite_border,
//                                                   size: 30,
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 30,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Text(
//                                           'Quantity',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             if (counter > 1) {
//                                               counter--;
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           color: Colors.orange,
//                                           width: 30,
//                                           height: 30,
//                                           child: const Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               '-',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         '$counter',
//                                         style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             counter++;
//                                           });
//                                         },
//                                         child: Container(
//                                           color: Colors.orange,
//                                           width: 30,
//                                           height: 30,
//                                           child: const Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               '+',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 30,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 20),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 15),
//                                           child: Text(
//                                             'Size',
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         // Spacer(),
//                                         MaterialButton(
//                                           color: Colors.orange,
//                                           onPressed: () {},
//                                           child: Text(
//                                             'fgdf',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                       },
//                     );
//                     // Navigator.pushNamed(context, '${widget.foodDetailsRoute}',
//                     //     arguments: {
//                     //       'name': name,
//                     //       'imageUrl': imageUrl,
//                     //       'price': price,
//                     //     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 10, bottom: 10),
//                     child: Container(
//                       color: Colors.orange,
//                       child: ListTile(
//                           leading: Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.orange,
//                               image: imageUrl.isNotEmpty
//                                   ? DecorationImage(
//                                       image: NetworkImage(imageUrl),
//                                       fit: BoxFit.cover,
//                                     )
//                                   : null,
//                             ),
//                             child: imageUrl.isEmpty
//                                 ? const Icon(
//                                     Icons.image,
//                                     size: 50,
//                                     color: Colors.white,
//                                   )
//                                 : null,
//                           ),
//                           title: Text(name),
//                           subtitle: Text('\$${price.toString()}'),
//                           trailing: isAdmin
//                               ? Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => UpdateFood(
//                                               docId: doc.id,
//                                               foodData: data,
//                                               collectionName:
//                                                   widget.collectionName,
//                                               categoryName: categoryName,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         foodRef.doc(doc.id).delete();
//                                         customShowSnackBar(
//                                             context: context,
//                                             content:
//                                                 '$name is deleted from ${widget.collectionName}');
//                                       },
//                                       icon: const Icon(
//                                         Icons.delete,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : null),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void updateAllDocuments(CollectionReference foodRef) async {
//     QuerySnapshot snapshot = await foodRef.get();
//     for (DocumentSnapshot doc in snapshot.docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       final name = data['name'] as String?;
//       if (name != null) {
//         await doc.reference.update({
//           'name_lowercase': name.toLowerCase(),
//         });
//       }
//     }
//   }
// }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
// // import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// // class Product {
// //   final String name;
// //   final double price;

// //   Product(this.name, this.price);
// // }

// // class FoodList extends StatefulWidget {
// //   final String collectionName;
// //   final String searchQuery;
// //   final String foodName;
// //   final String foodDetailsRoute;

// //   FoodList({
// //     super.key,
// //     required this.collectionName,
// //     required this.searchQuery,
// //     required this.foodName,
// //     required this.foodDetailsRoute,
// //   });

// //   @override
// //   State<FoodList> createState() => _FoodListState();
// // }

// // class _FoodListState extends State<FoodList> {
// //   int counter = 1;
// //   String selectedSize = 'Small'; // Default size

// //   final List<String> burgerSizes = ['Small', 'Medium', 'Large'];

// //   final List<Product> products = [
// //     Product('Chicken(\$2.00)', 2.00),
// //     Product('Beef(\$3.00)', 3.00),
// //     Product('Paprika(\$2.00)', 2.00),
// //     Product('Cheese(\$2.00)', 2.00),
// //     Product('Pickle(\$2.00)', 2.00),
// //     Product('Angus Beef(\$5.00)', 5.00),
// //     Product('Potato(\$2.00)', 2.00),
// //     Product('Broccoli(\$2.00)', 2.00),
// //     Product('Onion(\$2.00)', 2.00),
// //     Product('Fries(\$4.00)', 4.00),
// //   ];

// //   final Map<Product, double> selectedProducts = {};
// //   double _totalPrice = 0.0;

// //   void getTotalPrice() {
// //     double totalPrice = 0.0;
// //     for (var entry in selectedProducts.entries) {
// //       final product = entry.key;
// //       final quantity = entry.value;
// //       totalPrice += product.price * quantity;
// //     }
// //     setState(() {
// //       _totalPrice = totalPrice;
// //     });
// //   }

// //   bool isAdmin = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     checkUserRole();
// //   }

// //   Future<void> checkUserRole() async {
// //     User? user = FirebaseAuth.instance.currentUser;

// //     if (user != null) {
// //       DocumentSnapshot adminDoc = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(user.uid)
// //           .get();

// //       if (adminDoc.exists) {
// //         String role = adminDoc.get('rool'); // Fix the field name here
// //         setState(() {
// //           isAdmin = role == 'admin';
// //         });
// //       } else {
// //         setState(() {
// //           isAdmin = false;
// //         });
// //       }
// //     } else {
// //       setState(() {
// //         isAdmin = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final CollectionReference foodRef =
// //         FirebaseFirestore.instance.collection(widget.collectionName);

// //     final String lowercaseQuery = widget.searchQuery.toLowerCase();

// //     // Update all documents to ensure they have 'name_lowercase'
// //     updateAllDocuments(foodRef);

// //     // Determine the stream based on whether there is a search query
// //     final Stream<QuerySnapshot> stream = widget.searchQuery.isNotEmpty
// //         ? foodRef
// //             .where('name_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
// //             .where('name_lowercase',
// //                 isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
// //             .snapshots()
// //         : foodRef.orderBy('timestamp', descending: true).snapshots();

// //     return StreamBuilder<QuerySnapshot>(
// //       stream: stream,
// //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(
// //             child: CircularProgressIndicator(
// //               color: Colors.orange,
// //             ),
// //           );
// //         }

// //         if (snapshot.hasError) {
// //           return Center(
// //             child: Text(
// //               'Something went wrong: ${snapshot.error}',
// //               style: TextStyle(fontSize: 16, color: Colors.red),
// //             ),
// //           );
// //         }

// //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //           return Center(
// //             child: Text(
// //               widget.searchQuery.isNotEmpty
// //                   ? 'No results found for "${widget.searchQuery}".'
// //                   : 'No items available.',
// //               style: TextStyle(fontSize: 16, color: Colors.orange),
// //             ),
// //           );
// //         }

// //         final documents = snapshot.data!.docs;

// //         final String categoryName =
// //             (widget.collectionName == 'tea category') ? 'Drinks' : 'Foods';

// //         return ListView(
// //           padding: const EdgeInsets.all(20),
// //           physics: const BouncingScrollPhysics(),
// //           children: [
// //             const Text(
// //               "What is your",
// //               style: TextStyle(
// //                 fontSize: 30,
// //               ),
// //             ),
// //             Text(
// //               'favourite ${widget.foodName}?',
// //               style: const TextStyle(
// //                 fontSize: 30,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             ListView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: documents.length,
// //               itemBuilder: (context, index) {
// //                 final doc = documents[index];
// //                 final data = doc.data() as Map<String, dynamic>;
// //                 final imageUrl = data['image'] as String? ?? '';
// //                 final name = data['name'] as String? ?? '';
// //                 final price = data['price'];
// //                 return InkWell(
// //                   onTap: () {
// //                     showModalBottomSheet(
// //                       context: context,
// //                       builder: (BuildContext context) {
// //                         return StatefulBuilder(builder:
// //                             (BuildContext context, StateSetter setState) {
// //                           return Container(
// //                             height: 500,
// //                             decoration: BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius: BorderRadius.circular(20),
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 10, vertical: 10),
// //                               child: Column(
// //                                 children: [
// //                                   Row(
// //                                     children: [
// //                                       imageUrl.startsWith('http')
// //                                           ? Image.network(
// //                                               height: 120,
// //                                               width: 120,
// //                                               fit: BoxFit.contain,
// //                                               imageUrl,
// //                                             )
// //                                           : Icon(
// //                                               Icons.image,
// //                                               size: 120,
// //                                               color: Colors.black,
// //                                             ),
// //                                       const SizedBox(
// //                                         width: 20,
// //                                       ),
// //                                       Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: <Widget>[
// //                                           Container(
// //                                             constraints: BoxConstraints(
// //                                               maxWidth: 220,
// //                                             ),
// //                                             child: Text(
// //                                               name,
// //                                               softWrap: true,
// //                                               overflow: TextOverflow.clip,
// //                                               style: TextStyle(
// //                                                 fontSize: 25,
// //                                                 fontWeight: FontWeight.bold,
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           SizedBox(height: 5),
// //                                           Text(
// //                                             '⭐⭐⭐⭐⭐',
// //                                             style: TextStyle(fontSize: 13),
// //                                           ),
// //                                           SizedBox(height: 10),
// //                                           Row(
// //                                             mainAxisAlignment:
// //                                                 MainAxisAlignment.spaceEvenly,
// //                                             children: [
// //                                               Text(
// //                                                 '\$$price',
// //                                                 style: TextStyle(
// //                                                   fontSize: 23,
// //                                                   fontWeight: FontWeight.bold,
// //                                                 ),
// //                                               ),
// //                                               SizedBox(
// //                                                 width: MediaQuery.of(context)
// //                                                         .size
// //                                                         .width *
// //                                                     0.34,
// //                                               ),
// //                                               IconButton(
// //                                                 onPressed: () {},
// //                                                 icon: Icon(
// //                                                   Icons.favorite_border,
// //                                                   size: 30,
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           )
// //                                         ],
// //                                       )
// //                                     ],
// //                                   ),
// //                                   const SizedBox(
// //                                     height: 30,
// //                                   ),
// //                                   Row(
// //                                     children: [
// //                                       Padding(
// //                                         padding:
// //                                             const EdgeInsets.only(left: 10),
// //                                         child: Text(
// //                                           'Quantity',
// //                                           style: TextStyle(
// //                                             fontSize: 20,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Spacer(),
// //                                       InkWell(
// //                                         onTap: () {
// //                                           setState(() {
// //                                             if (counter > 1) {
// //                                               counter--;
// //                                             }
// //                                           });
// //                                         },
// //                                         child: Container(
// //                                           color: Colors.orange,
// //                                           width: 30,
// //                                           height: 30,
// //                                           child: const Align(
// //                                             alignment: Alignment.center,
// //                                             child: Text(
// //                                               '-',
// //                                               style: TextStyle(
// //                                                   color: Colors.white,
// //                                                   fontSize: 20,
// //                                                   fontWeight: FontWeight.bold),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 10,
// //                                       ),
// //                                       Text(
// //                                         '$counter',
// //                                         style: const TextStyle(
// //                                           fontSize: 20,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 10,
// //                                       ),
// //                                       InkWell(
// //                                         onTap: () {
// //                                           setState(() {
// //                                             counter++;
// //                                           });
// //                                         },
// //                                         child: Container(
// //                                           color: Colors.orange,
// //                                           width: 30,
// //                                           height: 30,
// //                                           child: const Align(
// //                                             alignment: Alignment.center,
// //                                             child: Text(
// //                                               '+',
// //                                               style: TextStyle(
// //                                                   color: Colors.white,
// //                                                   fontSize: 20,
// //                                                   fontWeight: FontWeight.bold),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   SizedBox(height: 20),
// //                                   Row(
// //                                     children: [
// //                                       Text(
// //                                         'Size',
// //                                         style: TextStyle(
// //                                           fontSize: 20,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                       SizedBox(width: 20),
// //                                       DropdownButton<String>(
// //                                         value: selectedSize,
// //                                         onChanged: (String? newValue) {
// //                                           setState(() {
// //                                             selectedSize = newValue!;
// //                                           });
// //                                         },
// //                                         items: burgerSizes.map((String size) {
// //                                           return DropdownMenuItem<String>(
// //                                             value: size,
// //                                             child: Text(size),
// //                                           );
// //                                         }).toList(),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(
// //                                     height: 30,
// //                                   ),
// //                                   ElevatedButton(
// //                                     onPressed: () {
// //                                       // Handle Add to Cart
// //                                       final product = Product(name, price);
// //                                       if (selectedProducts
// //                                           .containsKey(product)) {
// //                                         selectedProducts[product] =
// //                                             selectedProducts[product]! +
// //                                                 counter;
// //                                       } else {
// //                                         selectedProducts[product] =
// //                                             counter.toDouble();
// //                                       }
// //                                       getTotalPrice();
// //                                       Navigator.pop(context);
// //                                       ScaffoldMessenger.of(context)
// //                                           .showSnackBar(
// //                                         SnackBar(
// //                                           content: Text(
// //                                             'Added $counter x $selectedSize $name to cart.',
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                     child: Text('Add to Cart'),
// //                                     style: ElevatedButton.styleFrom(
// //                                         //primary: Colors.orange,
// //                                         ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           );
// //                         });
// //                       },
// //                     );
// //                   },
// //                   child: Card(
// //                     elevation: 5,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: ListTile(
// //                       contentPadding: const EdgeInsets.all(10),
// //                       leading: imageUrl.startsWith('http')
// //                           ? Image.network(
// //                               height: 100,
// //                               width: 100,
// //                               fit: BoxFit.cover,
// //                               imageUrl,
// //                             )
// //                           : Icon(
// //                               Icons.image,
// //                               size: 100,
// //                               color: Colors.black,
// //                             ),
// //                       title: Text(
// //                         name,
// //                         style: const TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                       subtitle: Text('\$$price'),
// //                       trailing: Icon(
// //                         Icons.arrow_forward_ios,
// //                         size: 20,
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void updateAllDocuments(CollectionReference collectionRef) async {
// //     final docs = await collectionRef.get();
// //     for (final doc in docs.docs) {
// //       final data = doc.data() as Map<String, dynamic>;
// //       final name = data['name'] as String? ?? '';
// //       await doc.reference.update({
// //         'name_lowercase': name.toLowerCase(),
// //       });
// //     }
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class FoodList extends StatefulWidget {
  final String collectionName;
  final String searchQuery;
  final String foodName;
  final String foodDetailsRoute;

  FoodList({
    super.key,
    required this.collectionName,
    required this.searchQuery,
    required this.foodName,
    required this.foodDetailsRoute,
  });

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  int counter = 0;
  String selectedSize = 'Small'; // Default size
  final List<String> burgerSizes = ['Small', 'Medium', 'Large'];

  final List<String> extras = [
    'Chicken(\$2.00)',
    'Beef(\$3.00)',
    'Paprika(\$2.00)',
    'Cheese(\$2.00)',
    'Pickle(\$2.00)',
    'Angus Beef(\$5.00)',
    'Potato(\$2.00)',
    'Broccoli(\$2.00)',
    'Onion(\$2.00)',
    'Fries(\$4.00)',
  ];

  final Map<String, bool> selectedExtras = {};
  double _totalPrice = 0.0;

  final Map<Product, double> selectedProducts = {}; // Define selectedProducts

  void calculateTotalPrice(double basePrice) {
    double totalPrice = basePrice;
    for (var entry in selectedExtras.entries) {
      if (entry.value) {
        // Extract price from the extra string
        final price = double.parse(entry.key.split('\$')[1].split(')')[0]);
        totalPrice += price;
      }
    }
    totalPrice *= counter;
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkUserRole();
    // Initialize selectedExtras
    for (var extra in extras) {
      selectedExtras[extra] = false;
    }
  }

  Future<void> checkUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (adminDoc.exists) {
        String role = adminDoc.get('rool'); // Fix the field name here
        setState(() {
          isAdmin = role == 'admin';
        });
      } else {
        setState(() {
          isAdmin = false;
        });
      }
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference foodRef =
        FirebaseFirestore.instance.collection(widget.collectionName);

    final String lowercaseQuery = widget.searchQuery.toLowerCase();

    // Update all documents to ensure they have 'name_lowercase'
    updateAllDocuments(foodRef);

    // Determine the stream based on whether there is a search query
    final Stream<QuerySnapshot> stream = widget.searchQuery.isNotEmpty
        ? foodRef
            .where('name_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
            .where('name_lowercase',
                isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
            .snapshots()
        : foodRef.orderBy('timestamp', descending: true).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
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
              'Something went wrong: ${snapshot.error}',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              widget.searchQuery.isNotEmpty
                  ? 'No results found for "${widget.searchQuery}".'
                  : 'No items available.',
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
          );
        }

        final documents = snapshot.data!.docs;

        return ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "What is your",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'favourite ${widget.foodName}?',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['image'] as String? ?? '';
                final name = data['name'] as String? ?? '';
                //final price = data['price'];
                final priceString = data['price'] as String ?? '0.0';
                final price = double.tryParse(priceString) ?? 0.0;

                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: 600,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                          border: Border.all(
                                              color: Colors.white,
                                              width:
                                                  2), // Optional: Add a border if desired
                                        ),
                                        child: imageUrl.startsWith('http')
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Ensure the border radius matches
                                                child: Image.network(
                                                  imageUrl,
                                                  height: 120,
                                                  width: 120,
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 220,
                                            ),
                                            child: Text(
                                              name,
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '⭐⭐⭐⭐⭐',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '\$$price',
                                                style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.favorite_border,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Quantity',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 140,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (counter > 0) {
                                                counter--;
                                                calculateTotalPrice(price);
                                              }
                                            });
                                          },
                                          child: Container(
                                            color: Colors.orange,
                                            width: 30,
                                            height: 30,
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '-',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '$counter',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              counter++;
                                              calculateTotalPrice(price);
                                            });
                                          },
                                          child: Container(
                                            color: Colors.orange,
                                            width: 30,
                                            height: 30,
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Size',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Wrap(
                                          spacing: 5,
                                          children: burgerSizes.map((size) {
                                            return ChoiceChip(
                                              label: Text(size),
                                              selected: selectedSize == size,
                                              onSelected: (selected) {
                                                setState(() {
                                                  selectedSize = size;
                                                });
                                              },
                                              selectedColor: Colors.orange,
                                              backgroundColor: Colors.grey[200],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  widget.collectionName == 'burger category' ||
                                          widget.collectionName ==
                                              'pizza category' ||
                                          widget.collectionName ==
                                              'chicken category' ||
                                          widget.collectionName ==
                                              'fish category' ||
                                          widget.collectionName ==
                                              'meat category' ||
                                          widget.collectionName ==
                                              'pasta category' ||
                                          widget.collectionName ==
                                              'sushi category' ||
                                          widget.collectionName ==
                                              'burger and fries1' ||
                                          widget.collectionName ==
                                              'burger and pepsi' ||
                                          widget.collectionName ==
                                              'chicken and rice' ||
                                          widget.collectionName ==
                                              'pasta and chicken' ||
                                          widget.collectionName ==
                                              'fish and rice' ||
                                          widget.collectionName ==
                                              'meat and juice'
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                          ),
                                          child: Text(
                                            'Extras',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Text(''),
                                  //SizedBox(height: 10),
                                  widget.collectionName == 'burger category' ||
                                          widget.collectionName ==
                                              'pizza category' ||
                                          widget.collectionName ==
                                              'chicken category' ||
                                          widget.collectionName ==
                                              'fish category' ||
                                          widget.collectionName ==
                                              'meat category' ||
                                          widget.collectionName ==
                                              'pasta category' ||
                                          widget.collectionName ==
                                              'sushi category' ||
                                          widget.collectionName ==
                                              'burger and fries1' ||
                                          widget.collectionName ==
                                              'burger and pepsi' ||
                                          widget.collectionName ==
                                              'chicken and rice' ||
                                          widget.collectionName ==
                                              'pasta and chicken' ||
                                          widget.collectionName ==
                                              'fish and rice' ||
                                          widget.collectionName ==
                                              'meat and juice'
                                      ? Container(
                                          height: 80,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: extras.length,
                                            itemBuilder: (context, index) {
                                              final extra = extras[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: ChoiceChip(
                                                  label: Text(extra),
                                                  selected:
                                                      selectedExtras[extra] ??
                                                          false,
                                                  onSelected: (selected) {
                                                    setState(() {
                                                      selectedExtras[extra] =
                                                          selected;
                                                      calculateTotalPrice(
                                                          price);
                                                    });
                                                  },
                                                  selectedColor: Colors.orange,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Text(''),
                                  // SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle Add to Cart
                                      final product = Product(name, price);
                                      if (selectedProducts
                                          .containsKey(product)) {
                                        selectedProducts[product] =
                                            selectedProducts[product]! +
                                                counter;
                                      } else {
                                        selectedProducts[product] =
                                            counter.toDouble();
                                      }
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added $counter x $selectedSize $name with ${selectedExtras.entries.where((e) => e.value).map((e) => e.key).join(", ")} to cart. Total Price: \$${_totalPrice.toStringAsFixed(2)}',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        // contentPadding: const EdgeInsets.all(10),
                        leading: imageUrl.startsWith('http')
                            ? Image.network(
                                height: 120,
                                width: 50,
                                // fit: BoxFit.contain,
                                imageUrl,
                              )
                            : Icon(
                                Icons.image,
                                size: 55,
                                color: Colors.black,
                              ),
                        title: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('\$$price'),
                        trailing: isAdmin
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateFood(
                                            docId: doc.id,
                                            foodData: data,
                                            collectionName:
                                                widget.collectionName,
                                            categoryName: '',
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      foodRef.doc(doc.id).delete();
                                      customShowSnackBar(
                                          context: context,
                                          content:
                                              '$name is deleted from ${widget.collectionName}');
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                        // trailing: isAdmin
                        //     ? Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {}, icon: Icon(Icons.edit)),
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(Icons.delete)),
                        //         ],
                        //       )
                        //     : Icon(
                        //         Icons.arrow_forward_ios,
                        //         size: 20,
                        //       ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void updateAllDocuments(CollectionReference collectionRef) async {
    final docs = await collectionRef.get();
    for (final doc in docs.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final name = data['name'] as String? ?? '';
      await doc.reference.update({
        'name_lowercase': name.toLowerCase(),
      });
    }
  }
}
