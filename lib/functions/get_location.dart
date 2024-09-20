// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';

// Future<void> getLocation(BuildContext context) async {
//     setState(() {
//       isLoading = true; // Show loading indicator
//     });

//     loc.LocationData? _currentLocation = await getCurrentLocation();

//     if (_currentLocation == null) {
//       setState(() {
//         isLoading = false; // Hide loading indicator
//       });
//       // Handle the error if location is not available
//       return;
//     }

//     // Convert coordinates to address
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       _currentLocation.latitude!,
//       _currentLocation.longitude!,
//     );

//     String _address;

//     if (placemarks.isNotEmpty) {
//       final placemark = placemarks.first;
//       _address = '${placemark.street}';
//     } else {
//       _address = 'Address not found';
//     }

//     // Update the address and hide loading indicator
//     setState(() {
//       deliveryAddress = _address;
//       isLoading = false;
//     });
//   }