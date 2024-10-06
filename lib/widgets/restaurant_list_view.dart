import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/Cubit/location%20cubit/location_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    deliveryAddress = widget.deliveryAddress;
    context.read<LocationCubit>().getLocation();
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
        const RestaurantCategories(),
      ],
    );
  }
}
