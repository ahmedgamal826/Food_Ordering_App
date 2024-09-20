import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/auth/profile_screen.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class RestaurantListView extends StatefulWidget {
  final String profileImageUrl;
  final String deliveryAddress;
  final authService;

  const RestaurantListView({
    Key? key,
    required this.profileImageUrl,
    required this.deliveryAddress,
    required this.authService,
  }) : super(key: key);

  @override
  State<RestaurantListView> createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  bool isLoading = false;
  String deliveryAddress = "";

  @override
  void initState() {
    super.initState();
    deliveryAddress = widget.deliveryAddress;
  }

  Future<loc.LocationData?> _getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<void> getLocation() async {
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

    setState(() {
      deliveryAddress = _address;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
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
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: widget.profileImageUrl.isNotEmpty
                            ? NetworkImage(widget.profileImageUrl)
                            : null,
                        child: widget.profileImageUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.orange,
                              )
                            : null,
                      ),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 23, top: 30),
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        '${widget.authService.userName ?? 'Loading...'}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await getLocation(); // Call the refactored getLocation method
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
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text('loading...'),
                                    )
                                  : Text(
                                      textAlign: TextAlign.start,
                                      deliveryAddress,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Let's enjoy",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              MaterialPageRoute(builder: (context) => const BurgersScreen()),
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
    );
  }
}
