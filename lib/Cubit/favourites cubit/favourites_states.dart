import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<DocumentSnapshot> favouriteItems;

  FavouriteLoaded(this.favouriteItems);
}

class FavouriteError extends FavouriteState {
  final String message;

  FavouriteError(this.message);
}
