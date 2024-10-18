// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
// import 'package:food_ordering_app/widgets/search_textform_field.dart';

// class OffersScreen extends StatefulWidget {
//   const OffersScreen({super.key});

//   @override
//   State<OffersScreen> createState() => _OffersScreenState();
// }

// class _OffersScreenState extends State<OffersScreen> {
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
//         leading: Text(''),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.orange,
//         title: const Text(
//           'Offers',
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
//               hintText: 'Search your offers...',
//               onChanged: updateSearchQuery,
//             ),
//           ),
//           Expanded(
//             child: FoodList(
//               collectionName: 'offers_category',
//               searchQuery: searchQuery,
//               foodName: 'Offers',
//               foodDetailsRoute: '',
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: isAdmin // Show button only if user is an admin
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
//                       collectionName: 'offers_category',
//                       categoryName: 'Offers',
//                     ),
//                   ),
//                 );
//               },
//             )
//           : null,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  String searchQuery = '';
  bool isAdmin = false;
  List<Map<String, dynamic>> offers = []; // List to hold offer data

  @override
  void initState() {
    super.initState();
    checkUserRole();
    fetchOffers(); // Fetch offers from Firestore
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

  Future<void> fetchOffers() async {
    QuerySnapshot offersSnapshot =
        await FirebaseFirestore.instance.collection('offers_category').get();

    setState(() {
      offers = offersSnapshot.docs
          .map((doc) => {
                'title': doc['title'], // Replace with your offer data field
                'offerDiscount':
                    doc['offerDiscount'], // Replace with discount field
                'image': doc['image'], // Replace with image URL field
              })
          .toList();
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        title: const Text(
          'Offers',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchTextformField(
              hintText: 'Search your offers...',
              onChanged: updateSearchQuery,
            ),
          ),
          Expanded(
            child: FoodList(
              collectionName: 'offers_category',
              searchQuery: searchQuery,
              foodName: 'Offers',
              foodDetailsRoute: '',
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.add,
                size: 33,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFoodPage(
                      collectionName: 'offers_category',
                      categoryName: 'Offers',
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}
