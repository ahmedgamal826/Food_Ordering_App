import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';
import 'package:food_ordering_app/widgets/map_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import 'package:location/location.dart' as loc;

class RestaurantHomePage extends StatefulWidget {
  const RestaurantHomePage({super.key});

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  bool isLoading = false;
  String deliveryAddress = "";

  @override
  void initState() {
    super.initState();
    // استدعاء getLocation عند تحميل الصفحة تلقائياً
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocation(context, setState);
    });
  }

  Future<void> logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminOrUserScreen(),
      ),
    ).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Method to get the current location
  Future<loc.LocationData?> _getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    // Return current location
    return await location.getLocation();
  }

  // Method to get the address and show it in a dialog
  Future<void> getLocation(BuildContext context, StateSetter setState) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    loc.LocationData? _currentLocation = await _getCurrentLocation();

    if (_currentLocation == null) {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      // Handle the error if location is not available
      return;
    }

    // Convert coordinates to address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentLocation.latitude!,
      _currentLocation.longitude!,
    );

    String _address;

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      _address = '${placemark.street}';
    } else {
      _address = 'Address not found';
    }

    // Update the address and hide loading indicator
    setState(() {
      deliveryAddress = _address;
      isLoading = false;
    });
  }

  // Show the address in a dialog
  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     title: const Text(
  //       "Current Address",
  //       style: TextStyle(
  //         color: Colors.orange,
  //       ),
  //     ),
  //     content: isLoading
  //         ? const Center(
  //             child: CircularProgressIndicator(
  //               color: Colors.orange,
  //             ),
  //           )
  //         : Text(
  //             _address,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //     actions: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _navigateToMap(context, _currentLocation);
  //             },
  //             child: const Text(
  //               "View on Map",
  //               style: TextStyle(
  //                   fontSize: 17,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
  //             onPressed: () {
  //               if (mounted) {
  //                 Navigator.of(context).pop();
  //                 // setState(() {
  //                 //   // _updateAddress(_address); // Update the address here
  //                 //   Navigator.of(context).pop(); // Close the dialog
  //                 // });
  //               }
  //             },
  //             child: const Text(
  //               "OK",
  //               style: TextStyle(
  //                   fontSize: 17,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  // );

  void _navigateToMap(
      BuildContext context, loc.LocationData? locationData) async {
    if (locationData == null) {
      locationData = await _getCurrentLocation();
    }

    if (locationData == null) {
      // Handle the error if location is not available
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          locationData: locationData!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: Text(''));
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Check if user is logged in
          if (!authService.isLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: const Center(
                child: Text('User is not logged in'),
              ),
            );
          }

          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser == null) {
            return const Center(child: Text('No user found.'));
          }

          // Use StreamBuilder to listen for profile changes in Firestore
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
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Row(
                        children: [
                          isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.orange,
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: profileImageUrl != null
                                        ? NetworkImage(profileImageUrl)
                                        : null,
                                    child: profileImageUrl == null
                                        ? const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.orange,
                                          )
                                        : null,
                                  ),
                                ),
                          // const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 23, top: 30),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    '${authService.userName ?? 'Loading...'}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await getLocation(context, setState);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 35,
                                        ),
                                        Expanded(
                                          child: isLoading
                                              ? const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 40),
                                                  child: Text('loading...'),
                                                )
                                              : Text(
                                                  textAlign: TextAlign.start,
                                                  deliveryAddress,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Let's enjoy",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'tasty meals, drinks, and desserts!',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CategoryListView(
                      categoryName: 'Foods',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BurgersScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CategoryListView(
                      categoryName: 'Drinks',
                      onTap: () {
                        Navigator.pushNamed(context, 'drinksScreen');
                      },
                    ),
                    const SizedBox(height: 20),
                    CategoryListView(
                      categoryName: 'Sweets',
                      onTap: () {
                        Navigator.pushNamed(context, 'sweetsScreen');
                      },
                    ),
                    const SizedBox(height: 20),
                    CategoryListView(
                      categoryName: 'Popular Meals',
                      onTap: () {
                        Navigator.pushNamed(context, 'offersScreen');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
