import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
import 'package:food_ordering_app/components/offers_cards_home_screen.dart';
import 'package:food_ordering_app/widgets/my_name_and_location.dart';
import 'package:food_ordering_app/widgets/restaurant_categories.dart';
import 'package:food_ordering_app/widgets/restaurant_intro_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  String deliveryAddress = "";
  loc.LocationData? currentLocation;
  late GoogleMapController mapController;

  late PageController pageController;
  int currentPage = 0;
  List<Map<String, dynamic>> offers = []; // To hold the offers

  Future<List<Map<String, dynamic>>> fetchOffers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('offers_category') // Assuming this is the collection name
        .get();

    // Extract data from each document in the collection
    return querySnapshot.docs.map((doc) {
      return {
        'offerDiscount': doc['offerDiscount'], // Example field
        'name': doc['name'], // Example field
        'image': doc['image'], // Assuming you have a field for image URL
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    deliveryAddress = widget.deliveryAddress;
    context.read<LocationCubit>().getLocation();

    fetchOffers().then((offers) {
      setState(() {
        this.offers = offers;
      });
    });

    // Initialize PageController and set timer for automatic slide
    pageController = PageController(initialPage: currentPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (currentPage < offers.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }

        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        MyNameAndLocation(
          profileImageUrl: widget.profileImageUrl,
          authService: widget.authService,
        ),
        const SizedBox(height: 20),
        const RestaurantIntroWidget(),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.orange,
          indent: 25,
          endIndent: 25,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Text(
                'Offers for you',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  pageController.animateTo(
                    pageController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffF97316),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        OffersCards(pageController: pageController, offers: offers),
        const SizedBox(
          height: 20,
        ),
        const RestaurantCategories(),
      ],
    );
  }
}
