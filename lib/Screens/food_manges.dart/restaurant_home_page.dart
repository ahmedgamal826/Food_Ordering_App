// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_ordering_app/Cubit/location_cubit.dart';
// import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
// import 'package:food_ordering_app/auth/auth_services_user.dart';
// import 'package:food_ordering_app/widgets/restaurant_list_view.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:provider/provider.dart';

// import 'package:location/location.dart' as loc;

// class RestaurantHomePage extends StatefulWidget {
//   const RestaurantHomePage({super.key});

//   @override
//   State<RestaurantHomePage> createState() => _RestaurantHomePageState();
// }

// class _RestaurantHomePageState extends State<RestaurantHomePage> {
//   bool isLoading = false;
//   String deliveryAddress = "";

//   @override
//   void initState() {
//     super.initState();
//     // استدعاء getLocation عند تحميل الصفحة تلقائياً
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       getLocation(context, setState);
//     });
//   }

//   Future<void> logout(BuildContext context) async {
//     setState(() {
//       isLoading = true;
//     });

//     await FirebaseAuth.instance.signOut();

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const AdminOrUserScreen(),
//       ),
//     ).whenComplete(() {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   // Method to get the current location
//   Future<loc.LocationData?> _getCurrentLocation() async {
//     loc.Location location = loc.Location();
//     bool serviceEnabled;
//     loc.PermissionStatus permissionGranted;

//     // Check if location service is enabled
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return null;
//       }
//     }

//     // Check for location permissions
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == loc.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != loc.PermissionStatus.granted) {
//         return null;
//       }
//     }

//     // Return current location
//     return await location.getLocation();
//   }

//   // Method to get the address and show it in a dialog
//   Future<void> getLocation(BuildContext context, StateSetter setState) async {
//     setState(() {
//       isLoading = true; // Show loading indicator
//     });

//     loc.LocationData? _currentLocation = await _getCurrentLocation();

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

//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);

//     return BlocProvider(
//       create: (context) => LocationCubit()..getLocation(),
//       child: StreamBuilder<User?>(
//         stream: authService.authStateChanges,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//                 appBar: AppBar(
//                   title: const Text(''),
//                 ),
//                 body: Text(''));
//           } else if (snapshot.hasError) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text(''),
//               ),
//               body: Center(
//                 child: Text('Error: ${snapshot.error}'),
//               ),
//             );
//           } else {
//             // Check if user is logged in
//             if (!authService.isLoggedIn) {
//               return Scaffold(
//                 appBar: AppBar(
//                   title: const Text(''),
//                 ),
//                 body: const Center(
//                   child: Text('User is not logged in'),
//                 ),
//               );
//             }

//             User? currentUser = FirebaseAuth.instance.currentUser;
//             if (currentUser == null) {
//               return const Center(child: Text('No user found.'));
//             }

//             // Use StreamBuilder to listen for profile changes in Firestore
//             return StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('user_app')
//                   .doc(currentUser.uid)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Colors.orange),
//                   );
//                 }

//                 var userData = snapshot.data?.data() as Map<String, dynamic>?;
//                 String? profileImageUrl = userData?['profileImage'];

//                 return Scaffold(
//                   appBar: AppBar(
//                     automaticallyImplyLeading: false,
//                     backgroundColor: Colors.orange,
//                     centerTitle: true,
//                     title: const Text(
//                       'Restaurant Home Page',
//                       style: TextStyle(
//                         fontSize: 23,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   body: RestaurantListView(
//                     authService: authService,
//                     deliveryAddress: deliveryAddress,
//                     profileImageUrl: profileImageUrl as String? ?? '',
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/restaurant_list_view.dart';

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: const Text(''),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!authService.isLoggedIn) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: const Center(child: Text('User is not logged in')),
          );
        }

        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          return const Center(child: Text('No user found.'));
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_app')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            var userData = snapshot.data?.data() as Map<String, dynamic>?;
            String? profileImageUrl = userData?['profileImage'];

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.orange,
                centerTitle: true,
                title: const Text(
                  'Restaurant Home Page',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: BlocProvider(
                      create: (context) => LocationCubit()..getLocation(),
                      child: RestaurantListView(
                        authService: authService,
                        deliveryAddress: '', // يتم تحديث العنوان عبر Bloc
                        profileImageUrl: profileImageUrl as String? ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
