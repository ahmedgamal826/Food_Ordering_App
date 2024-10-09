import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FoodListState {
  const FoodListState();
}

class FoodListLoading extends FoodListState {
  const FoodListLoading();
}

class FoodListLoaded extends FoodListState {
  final List<DocumentSnapshot> documents;

  const FoodListLoaded(this.documents);
}

class FoodListError extends FoodListState {
  final String errorMessage;

  const FoodListError(this.errorMessage);
}
