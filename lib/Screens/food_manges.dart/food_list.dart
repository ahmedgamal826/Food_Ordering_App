// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';

// class FoodList extends StatelessWidget {
//   FoodList({super.key});

//   final CollectionReference foodRef =
//       FirebaseFirestore.instance.collection('foods');

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: foodRef.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.orange,
//               ),
//             );
//           }
//           return Padding(
//             padding: const EdgeInsets.all(20),
//             child: ListView(
//               children: snapshot.data!.docs.map((doc) {
//                 final data = doc.data() as Map<String, dynamic>;
//                 final imageUrl = data['image'] as String? ?? '';
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Container(
//                     color: Colors.orange,
//                     child: ListTile(
//                       leading: imageUrl.isNotEmpty
//                           ? Image.network(imageUrl,
//                               width: 50, height: 50, fit: BoxFit.cover)
//                           : Icon(
//                               Icons.image,
//                               size: 50,
//                               color: Colors.white,
//                             ),
//                       title: Text(doc['name']),
//                       subtitle: Text(doc['price'].toString()),
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
//                                     foodData:
//                                         doc.data() as Map<String, dynamic>,
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(
//                               Icons.edit,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               foodRef.doc(doc.id).delete();
//                             },
//                             icon: const Icon(
//                               Icons.delete,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//         });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/update_food.dart';

class FoodList extends StatelessWidget {
  FoodList({super.key});

  final CollectionReference foodRef =
      FirebaseFirestore.instance.collection('foods');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: foodRef
            .orderBy('timestamp', descending: true)
            .snapshots(), // تعديل الاستعلام لفرز حسب timestamp
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['image'] as String? ?? '';

                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    color: Colors.orange,
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // image is shown
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                              )
                            : const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                      title: Text(doc['name']),
                      subtitle: Text('\$${doc['price'].toString()}'),
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
                                    foodData:
                                        doc.data() as Map<String, dynamic>,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              foodRef.doc(doc.id).delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
