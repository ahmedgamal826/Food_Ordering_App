import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/maps_order_management_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import the geocoding package

class OrderManagementCard extends StatelessWidget {
  final String userName;
  final String formattedTime;
  final Map<String, dynamic> order;
  final List<dynamic> items;
  final double total;
  final String documentId;
  final Future<void> Function() getOrderCount;
  final String? pendingDeleteDocumentId;

  const OrderManagementCard({
    Key? key,
    required this.userName,
    required this.formattedTime,
    required this.order,
    required this.items,
    required this.total,
    required this.documentId,
    required this.getOrderCount,
    this.pendingDeleteDocumentId,
  }) : super(key: key);

  Future<void> _openMap(BuildContext context, String address) async {
    LatLng? coordinates = await _getCoordinatesFromAddress(address);
    if (coordinates != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MapOrderManagementScreen(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
          ),
        ),
      );
    } else {
      // Handle the case where the address could not be geocoded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Could not find location for the address: $address')),
      );
    }
  }

  Future<LatLng?> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return LatLng(location.latitude, location.longitude);
      }
    } catch (e) {
      print('Error occurred while fetching coordinates: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            title: Text(
              'Order by: $userName',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Order Time: $formattedTime',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Address: ${order['deliveryAddress'] ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final address = order['deliveryAddress'] ?? 'Unknown';
                          _openMap(
                              context, address); // Open map with the address
                        },
                        icon: const Icon(
                          size: 35,
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          //... other widget items
        ],
      ),
    );
  }
}
