// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:food_ordering_app/widgets/favourite_card.dart';

// class FavouriteScreen extends StatefulWidget {
//   @override
//   _FavouriteScreenState createState() => _FavouriteScreenState();
// }

// class _FavouriteScreenState extends State<FavouriteScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   List<DocumentSnapshot> favouriteItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFavourites();
//   }

//   Future<void> _loadFavourites() async {
//     final userId = _auth.currentUser?.uid;
//     if (userId != null) {
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('favourites')
//           .get();
//       setState(() {
//         favouriteItems = snapshot.docs;
//       });
//     }
//   }

//   Future<void> _removeFromFavourites(String docId) async {
//     final userId = _auth.currentUser?.uid;
//     if (userId != null) {
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('favourites')
//           .doc(docId)
//           .delete();
//       setState(() {
//         favouriteItems.removeWhere((doc) => doc.id == docId);
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
//           'My Favourites',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.orange,
//       ),
//       body: favouriteItems.isEmpty
//           ? const Center(
//               child: Text(
//                 'Favourites is Empty',
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
//               itemCount: favouriteItems.length,
//               itemBuilder: (context, index) {
//                 final doc = favouriteItems[index];
//                 final data = doc.data() as Map<String, dynamic>;
//                 final imageUrl = data['imageUrl'] as String? ?? '';
//                 final name = data['name'] as String? ?? '';
//                 final price = data['price'] as double? ?? 0.0;

//                 return FavouriteCard(
//                   docId: doc.id,
//                   imageUrl: imageUrl,
//                   name: name,
//                   onRemove: _removeFromFavourites,
//                   price: price,
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/favourites%20cubit/favourites_cubit.dart';
import 'package:food_ordering_app/Cubit/favourites%20cubit/favourites_states.dart';
import 'package:food_ordering_app/widgets/favourite_card.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
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
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else if (state is FavouriteLoaded) {
            if (state.favouriteItems.isEmpty) {
              return const Center(
                child: Text(
                  'Favourites is Empty',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6,
              ),
              itemCount: state.favouriteItems.length,
              itemBuilder: (context, index) {
                final doc = state.favouriteItems[index];
                final data = doc.data() as Map<String, dynamic>;
                final imageUrl = data['imageUrl'] as String? ?? '';
                final name = data['name'] as String? ?? '';
                final price = data['price'] as double? ?? 0.0;

                return FavouriteCard(
                  docId: doc.id,
                  imageUrl: imageUrl,
                  name: name,
                  onRemove: context.read<FavouriteCubit>().removeFromFavourites,
                  price: price,
                );
              },
            );
          } else if (state is FavouriteError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
