import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/favourites%20cubit/favourites_states.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavouriteCubit() : super(FavouriteInitial());

  Future<void> loadFavourites() async {
    emit(FavouriteLoading());
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      try {
        final snapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('favourites')
            .get();

        emit(FavouriteLoaded(snapshot.docs));
      } catch (e) {
        emit(FavouriteError('Failed to load favourites: $e'));
      }
    } else {
      emit(FavouriteError('User not logged in'));
    }
  }

  Future<void> removeFromFavourites(String docId) async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favourites')
          .doc(docId)
          .delete();
      loadFavourites(); // Reload favourites after removal
    }
  }
}
