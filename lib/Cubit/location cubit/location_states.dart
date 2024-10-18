// Cubit State
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String address;
  final double latitude;
  final double longitude;
  LocationLoaded(this.address, this.latitude, this.longitude);
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}
