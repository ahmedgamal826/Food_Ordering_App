import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOrderManagementScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapOrderManagementScreen(
      {required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapOrderManagementScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.0,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: {
          Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(widget.latitude, widget.longitude),
          ),
        },
      ),
    );
  }
}
