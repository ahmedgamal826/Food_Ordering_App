// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
// // // import 'package:food_ordering_app/widgets/search_textform_field.dart';
// // // import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// // // class FoodList extends StatelessWidget {
// // //   final String collectionName;
// // //   final String searchQuery;

// // //   FoodList(
// // //       {super.key, required this.collectionName, required this.searchQuery});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final CollectionReference foodRef =
// // //         FirebaseFirestore.instance.collection(collectionName);

// // //     return StreamBuilder(
// // //       stream: searchQuery.isNotEmpty
// // //           ? foodRef
// // //               .where('name', isGreaterThanOrEqualTo: searchQuery)
// // //               .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
// // //               .orderBy('timestamp', descending: true)
// // //               .snapshots()
// // //           : foodRef.orderBy('timestamp', descending: true).snapshots(),
// // //       // stream: foodRef.orderBy('timestamp', descending: true).snapshots(),
// // //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// // //         if (!snapshot.hasData) {
// // //           return const Center(
// // //             child: CircularProgressIndicator(
// // //               color: Colors.orange,
// // //             ),
// // //           );
// // //         }

// // //         return ListView(
// // //           padding: const EdgeInsets.all(20),
// // //           physics: const BouncingScrollPhysics(),
// // //           children: [
// // //             const Text(
// // //               "What is your",
// // //               style: TextStyle(
// // //                 fontSize: 30,
// // //               ),
// // //             ),
// // //             const Text(
// // //               'favourite burger?',
// // //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             // SearchTextformField(
// // //             //   hintText: 'Search your burger...',
// // //             // ),
// // //             const SizedBox(height: 20),
// // //             ListView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: snapshot.data!.docs.length,
// // //               itemBuilder: (context, index) {
// // //                 final doc = snapshot.data!.docs[index];
// // //                 final data = doc.data() as Map<String, dynamic>;
// // //                 final imageUrl = data['image'] as String? ?? '';
// // //                 final name = data['name'] as String? ?? '';
// // //                 final price = data['price'];
// // //                 return Padding(
// // //                   padding: const EdgeInsets.only(top: 10, bottom: 10),
// // //                   child: Container(
// // //                     color: Colors.orange,
// // //                     child: ListTile(
// // //                       leading: Container(
// // //                         width: 50,
// // //                         height: 50,
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.orange,
// // //                           image: imageUrl.isNotEmpty
// // //                               ? DecorationImage(
// // //                                   image: NetworkImage(imageUrl),
// // //                                   fit: BoxFit.cover,
// // //                                 )
// // //                               : null,
// // //                         ),
// // //                         child: imageUrl.isEmpty
// // //                             ? const Icon(
// // //                                 Icons.image,
// // //                                 size: 50,
// // //                                 color: Colors.white,
// // //                               )
// // //                             : null,
// // //                       ),
// // //                       title: Text(name),
// // //                       subtitle: Text('\$${price.toString()}'),
// // //                       trailing: Row(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: [
// // //                           IconButton(
// // //                             onPressed: () {
// // //                               Navigator.push(
// // //                                 context,
// // //                                 MaterialPageRoute(
// // //                                   builder: (context) => UpdateFood(
// // //                                     docId: doc.id,
// // //                                     foodData: data,
// // //                                     collectionName: collectionName,
// // //                                   ),
// // //                                 ),
// // //                               );
// // //                             },
// // //                             icon: const Icon(
// // //                               Icons.edit,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ),
// // //                           IconButton(
// // //                             onPressed: () {
// // //                               foodRef.doc(doc.id).delete();
// // //                               customShowSnackBar(
// // //                                   context: context,
// // //                                   content:
// // //                                       '$name is deleted from $collectionName');
// // //                             },
// // //                             icon: const Icon(
// // //                               Icons.delete,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
// // import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// // class FoodList extends StatelessWidget {
// //   final String collectionName;
// //   final String searchQuery;

// //   FoodList(
// //       {super.key, required this.collectionName, required this.searchQuery});

// //   @override
// //   Widget build(BuildContext context) {
// //     final CollectionReference foodRef =
// //         FirebaseFirestore.instance.collection(collectionName);

// //     // Determine the stream based on whether there is a search query
// //     final Stream<QuerySnapshot> stream = searchQuery.isNotEmpty
// //         ? foodRef
// //             .where('name', isGreaterThanOrEqualTo: searchQuery)
// //             .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
// //             .orderBy('timestamp', descending: true)
// //             .snapshots()
// //         : foodRef.orderBy('timestamp', descending: true).snapshots();

// //     return StreamBuilder<QuerySnapshot>(
// //       stream: stream,
// //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (!snapshot.hasData) {
// //           return const Center(
// //             child: CircularProgressIndicator(
// //               color: Colors.blue,
// //             ),
// //           );
// //         }

// //         final documents = snapshot.data!.docs;

// //         // Check if no results were found
// //         if (documents.isEmpty && searchQuery.isNotEmpty) {
// //           return Center(
// //             child: Text(
// //               'No results found for "$searchQuery". Showing all items.',
// //               style: TextStyle(fontSize: 16, color: Colors.orange),
// //               textAlign: TextAlign.center,
// //             ),
// //           );
// //         }

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
// //             const Text(
// //               'favourite burger?',
// //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
// //                 return Padding(
// //                   padding: const EdgeInsets.only(top: 10, bottom: 10),
// //                   child: Container(
// //                     color: Colors.orange,
// //                     child: ListTile(
// //                       leading: Container(
// //                         width: 50,
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           color: Colors.orange,
// //                           image: imageUrl.isNotEmpty
// //                               ? DecorationImage(
// //                                   image: NetworkImage(imageUrl),
// //                                   fit: BoxFit.cover,
// //                                 )
// //                               : null,
// //                         ),
// //                         child: imageUrl.isEmpty
// //                             ? const Icon(
// //                                 Icons.image,
// //                                 size: 50,
// //                                 color: Colors.white,
// //                               )
// //                             : null,
// //                       ),
// //                       title: Text(name),
// //                       subtitle: Text('\$${price.toString()}'),
// //                       trailing: Row(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           IconButton(
// //                             onPressed: () {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) => UpdateFood(
// //                                     docId: doc.id,
// //                                     foodData: data,
// //                                     collectionName: collectionName,
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                             icon: const Icon(
// //                               Icons.edit,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           IconButton(
// //                             onPressed: () {
// //                               foodRef.doc(doc.id).delete();
// //                               customShowSnackBar(
// //                                   context: context,
// //                                   content:
// //                                       '$name is deleted from $collectionName');
// //                             },
// //                             icon: const Icon(
// //                               Icons.delete,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ],
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
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
// import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// class FoodList extends StatelessWidget {
//   final String collectionName;
//   final String searchQuery;

//   FoodList(
//       {super.key, required this.collectionName, required this.searchQuery});

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference foodRef =
//         FirebaseFirestore.instance.collection(collectionName);

//     final String lowercaseQuery = searchQuery.toLowerCase();

//     // Determine the stream based on whether there is a search query
//     // final Stream<QuerySnapshot> stream = searchQuery.isNotEmpty
//     //     ? foodRef
//     //         .where('name', isGreaterThanOrEqualTo: searchQuery)
//     //         .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
//     //         .snapshots() // Remove orderBy here
//     //     : foodRef.orderBy('timestamp', descending: true).snapshots();

//     final Stream<QuerySnapshot> stream = searchQuery.isNotEmpty
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
//               searchQuery.isNotEmpty
//                   ? 'No results found for "$searchQuery".'
//                   : 'No items available.',
//               style: TextStyle(fontSize: 16, color: Colors.orange),
//             ),
//           );
//         }

//         final documents = snapshot.data!.docs;

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
//             const Text(
//               'favourite burger?',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Container(
//                     color: Colors.orange,
//                     child: ListTile(
//                       leading: Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.orange,
//                           image: imageUrl.isNotEmpty
//                               ? DecorationImage(
//                                   image: NetworkImage(imageUrl),
//                                   fit: BoxFit.cover,
//                                 )
//                               : null,
//                         ),
//                         child: imageUrl.isEmpty
//                             ? const Icon(
//                                 Icons.image,
//                                 size: 50,
//                                 color: Colors.white,
//                               )
//                             : null,
//                       ),
//                       title: Text(name),
//                       subtitle: Text('\$${price.toString()}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => UpdateFood(
//                                     docId: doc.id,
//                                     foodData: data,
//                                     collectionName: collectionName,
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               foodRef.doc(doc.id).delete();
//                               customShowSnackBar(
//                                   context: context,
//                                   content:
//                                       '$name is deleted from $collectionName');
//                             },
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
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
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class FoodList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final CollectionReference foodRef =
        FirebaseFirestore.instance.collection(collectionName);

    final String lowercaseQuery = searchQuery.toLowerCase();

    // Update all documents to ensure they have 'name_lowercase'
    updateAllDocuments(foodRef);

    // Determine the stream based on whether there is a search query
    final Stream<QuerySnapshot> stream = searchQuery.isNotEmpty
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
              searchQuery.isNotEmpty
                  ? 'No results found for "$searchQuery".'
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
              'favourite $foodName?',
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
                final price = data['price'];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '$foodDetailsRoute');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      color: Colors.orange,
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            image: imageUrl.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: imageUrl.isEmpty
                              ? const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        title: Text(name),
                        subtitle: Text('\$${price.toString()}'),
                        trailing: Row(
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
                                      collectionName: collectionName,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                foodRef.doc(doc.id).delete();
                                customShowSnackBar(
                                    context: context,
                                    content:
                                        '$name is deleted from $collectionName');
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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

  void updateAllDocuments(CollectionReference foodRef) async {
    QuerySnapshot snapshot = await foodRef.get();
    for (DocumentSnapshot doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final name = data['name'] as String?;
      if (name != null) {
        await doc.reference.update({
          'name_lowercase': name.toLowerCase(),
        });
      }
    }
  }
}
