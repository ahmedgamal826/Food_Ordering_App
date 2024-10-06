import 'package:bloc/bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_states.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> getLocation() async {
    try {
      emit(LocationLoading());

      loc.Location location = loc.Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(LocationError("Location services are disabled"));
          return;
        }
      }

      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          emit(LocationError("Location permissions are denied"));
          return;
        }
      }

      final loc.LocationData locationData = await location.getLocation();
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      String address = 'Address not found';
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        address = placemark.street ?? 'Address not found';
      }

      emit(LocationLoaded(address));
    } catch (e) {
      emit(LocationError("Failed to get location"));
    }
  }
}
