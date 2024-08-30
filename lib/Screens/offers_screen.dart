// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// // // import 'package:food_ordering_app/widgets/offer_list.dart';
// // // import 'package:food_ordering_app/widgets/search_textform_field.dart';

// // // class OffersScreen extends StatefulWidget {
// // //   @override
// // //   State<OffersScreen> createState() => _OffersScreenState();
// // // }

// // // class _OffersScreenState extends State<OffersScreen> {
// // //   String searchQuery = '';
// // //   bool isAdmin = false;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     checkUserRole();
// // //   }

// // //   Future<void> checkUserRole() async {
// // //     User? user = FirebaseAuth.instance.currentUser;

// // //     if (user != null) {
// // //       DocumentSnapshot adminDoc = await FirebaseFirestore.instance
// // //           .collection('users')
// // //           .doc(user.uid)
// // //           .get();

// // //       if (adminDoc.exists) {
// // //         String role = adminDoc.get('rool'); // Fix the field name here
// // //         setState(() {
// // //           isAdmin = role == 'admin';
// // //         });
// // //       } else {
// // //         setState(() {
// // //           isAdmin = false;
// // //         });
// // //       }
// // //     } else {
// // //       setState(() {
// // //         isAdmin = false;
// // //       });
// // //     }
// // //   }

// // //   void updateSearchQuery(String query) {
// // //     setState(() {
// // //       searchQuery = query;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         iconTheme: const IconThemeData(color: Colors.white),
// // //         backgroundColor: Colors.orange,
// // //         title: const Text(
// // //           'Burgers',
// // //           style: TextStyle(
// // //             fontSize: 25,
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.white,
// // //           ),
// // //         ),
// // //         centerTitle: true,
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16),
// // //             child: SearchTextformField(
// // //               hintText: 'Search your burger...',
// // //               onChanged: updateSearchQuery,
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: OffersList(),
// // //           ),
// // //         ],
// // //       ),
// // //       floatingActionButton: isAdmin // Show button only if user is an admin
// // //           ? FloatingActionButton(
// // //               backgroundColor: Colors.orange,
// // //               child: const Icon(
// // //                 Icons.add,
// // //                 size: 33,
// // //                 color: Colors.white,
// // //               ),
// // //               onPressed: () {
// // //                 Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(
// // //                     builder: (context) => AddFoodPage(
// // //                       collectionName: 'offers_category',
// // //                       categoryName: 'Foods',
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             )
// // //           : null,
// // //     );
// // //   }
// // // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/Screens/add_discount_food.dart';
// // import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// // import 'package:food_ordering_app/widgets/offer_list.dart';
// // import 'package:food_ordering_app/widgets/search_textform_field.dart';

// // class OffersScreen extends StatefulWidget {
// //   @override
// //   State<OffersScreen> createState() => _OffersScreenState();
// // }

// // class _OffersScreenState extends State<OffersScreen> {
// //   String searchQuery = '';
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

// //   void updateSearchQuery(String query) {
// //     setState(() {
// //       searchQuery = query;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         backgroundColor: Colors.orange,
// //         title: const Text(
// //           'Burgers',
// //           style: TextStyle(
// //             fontSize: 25,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             child: SearchTextformField(
// //               hintText: 'Search your burger...',
// //               onChanged: updateSearchQuery,
// //             ),
// //           ),
// //           Expanded(
// //             child: OffersList(),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: isAdmin // Show button only if user is an admin
// //           ? FloatingActionButton(
// //               backgroundColor: Colors.orange,
// //               child: const Icon(
// //                 Icons.add,
// //                 size: 33,
// //                 color: Colors.white,
// //               ),
// //               onPressed: () async {
// //                 final newOffer = await Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => AddDiscountFood(
// //                       collectionName: 'offers_category',
// //                       categoryName: 'Foods',
// //                     ),
// //                   ),
// //                 );

// //                 if (newOffer != null) {
// //                   // Assuming OffersList is stateful and has a method to add offers
// //                   setState(() {
// //                     offers.add(newOffer);
// //                   });
// //                 }
// //               },
// //             )
// //           : null,
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/add_discount_food.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/add_food_page.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
// import 'package:food_ordering_app/widgets/offer_list.dart';
// import 'package:food_ordering_app/widgets/search_textform_field.dart';
// import 'package:food_ordering_app/models/offers_model.dart'; // Import the Offer model

// class OffersScreen extends StatefulWidget {
//   @override
//   State<OffersScreen> createState() => _OffersScreenState();
// }

// class _OffersScreenState extends State<OffersScreen> {
//   String searchQuery = '';
//   bool isAdmin = false;
//   List<Offer> offers = []; // Define the offers list here

//   @override
//   void initState() {
//     super.initState();
//     checkUserRole();
//     // Optionally, load offers from Firestore here if they are stored in the database
//     // loadOffersFromFirestore();
//   }

//   Future<void> checkUserRole() async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       DocumentSnapshot adminDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       if (adminDoc.exists) {
//         String role = adminDoc.get('rool');
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
//               hintText: 'Search your burger...',
//               onChanged: updateSearchQuery,
//             ),
//           ),
//           Expanded(
//             child: FoodList(
//               collectionName: 'offers_category',
//               foodDetailsRoute: '',
//               searchQuery: searchQuery,
//               foodName: 'Offers Food',
//             ), // Pass the offers list to OffersList
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
//               onPressed: () async {
//                 final newOffer = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AddFoodPage(
//                       collectionName: 'offers_category',
//                       categoryName: 'Offers Food',
//                     ),
//                   ),
//                 );

//                 if (newOffer != null) {
//                   setState(() {
//                     offers.add(newOffer); // Add the new offer to the list
//                   });
//                 }
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

  @override
  void initState() {
    super.initState();
    checkUserRole();
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
      floatingActionButton: isAdmin // Show button only if user is an admin
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
