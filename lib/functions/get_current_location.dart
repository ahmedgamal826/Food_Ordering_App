// // Method to get the current location
// import 'package:location/location.dart' as loc;

// Future<loc.LocationData?> getCurrentLocation() async {
//   loc.Location location = loc.Location();
//   bool serviceEnabled;
//   loc.PermissionStatus permissionGranted;

//   // Check if location service is enabled
//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return null;
//     }
//   }

//   // Check for location permissions
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == loc.PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != loc.PermissionStatus.granted) {
//       return null;
//     }
//   }

//   // Return current location
//   return await location.getLocation();
// }
