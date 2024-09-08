// import 'package:flutter/material.dart';

// class FavouriteScreen extends StatelessWidget {
//   FavouriteScreen({required this.favourites});

//   List<Map<String, dynamic>> favourites = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favourites'),
//       ),
//       body: ListView.builder(
//         itemCount: favourites.length,
//         itemBuilder: (context, index) {
//           final item = favourites[index];
//           return ListTile(
//             title: Text(item['name']),
//             subtitle: Text('\$${item['price']}'),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> favouriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  // Future<void> _loadFavourites() async {
  //   final userId = _auth.currentUser?.uid;
  //   if (userId != null) {
  //     final snapshot = await _firestore
  //         .collection('favourites')
  //         .where('userId',
  //             isEqualTo:
  //                 userId) // Assuming 'userId' is the field that stores the user's ID
  //         .get();
  //     setState(() {
  //       favouriteItems = snapshot.docs;
  //     });
  //   }
  // }

  Future<void> _loadFavourites() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favourites')
          .get();
      setState(() {
        favouriteItems = snapshot.docs;
      });
    }
  }

  Future<void> _removeFromFavourites(String docId) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favourites')
          .doc(docId)
          .delete();
      setState(() {
        favouriteItems.removeWhere((doc) => doc.id == docId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: const Text(
          'My Favourites',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: favouriteItems.isEmpty
          ? const Center(
              child: Text(
                'Favourites is Empty',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6,
              ),
              itemCount: favouriteItems.length,
              itemBuilder: (context, index) {
                final doc = favouriteItems[index];
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['imageUrl'] as String? ?? '';
                final name = data['name'] as String? ?? '';
                final price = data['price'] as double? ?? 0.0;

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: imageUrl.startsWith('http')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 120,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '\$$price',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _removeFromFavourites(doc.id);
                                customShowSnackBar(
                                  context: context,
                                  content: '$name is deleted from favourites',
                                );
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
