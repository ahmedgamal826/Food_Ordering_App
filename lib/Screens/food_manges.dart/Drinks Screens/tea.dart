// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
// import 'package:food_ordering_app/widgets/search_textform_field.dart';

// class Tea extends StatefulWidget {
//   const Tea({super.key});

//   @override
//   State<Tea> createState() => _TeaState();
// }

// class _TeaState extends State<Tea> {
//   String searchQuery = '';
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

//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.orange,
//         title: const Text(
//           'Tea',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: SearchTextformField(
//               hintText: 'Search your tea...',
//               onChanged: updateSearchQuery, // Pass the function here
//             ),
//           ),
//           Expanded(
//             child: FoodList(
//               collectionName: 'tea category',
//               searchQuery: searchQuery, // Pass the searchQuery here
//               foodName: 'tea',
//               foodDetailsRoute: 'tea',
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: isAdmin
//           ? FloatingActionButton(
//               backgroundColor: Colors.orange,
//               child: const Icon(
//                 Icons.add,
//                 size: 33,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AddFoodPage(
//                       collectionName: 'tea category',
//                       categoryName: 'Drinks',
//                     ),
//                   ),
//                 );
//               },
//             )
//           : null,
//     );
//   }
// }
