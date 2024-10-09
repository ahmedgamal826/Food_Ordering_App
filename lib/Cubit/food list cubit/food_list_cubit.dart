import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/Cubit/food%20list%20cubit/food_list_states.dart';

class FoodListCubit extends Cubit<FoodListState> {
  final FirebaseFirestore _firestore;

  FoodListCubit(this._firestore) : super(const FoodListLoading());

  void loadFoodItems(String collectionName, String searchQuery) async {
    emit(const FoodListLoading());

    try {
      final CollectionReference foodRef = _firestore.collection(collectionName);
      final String lowercaseQuery = searchQuery.toLowerCase();

      final Stream<QuerySnapshot> stream = searchQuery.isNotEmpty
          ? foodRef
              .where('name_lowercase', isGreaterThanOrEqualTo: lowercaseQuery)
              .where('name_lowercase',
                  isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
              .snapshots()
          : foodRef.orderBy('timestamp', descending: true).snapshots();

      stream.listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          emit(FoodListLoaded(snapshot.docs));
        } else {
          emit(const FoodListError('No items available.'));
        }
      });
    } catch (error) {
      emit(FoodListError(error.toString()));
    }
  }
}
