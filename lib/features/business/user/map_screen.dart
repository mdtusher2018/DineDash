import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.longitude, required this.latitude});
  final double? latitude, longitude;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  bool isMapLoading = true; // Track map loading state
  Set<Marker> _markers = {}; // Set to store the markers

  @override
  void initState() {
    super.initState();

    if (widget.latitude != null && widget.longitude != null) {
      // Add a marker on the map for the target location
      _markers.add(
        Marker(
          markerId: MarkerId('target_location'), // Unique ID for the marker
          position: LatLng(widget.latitude!, widget.longitude!), // Target position
          infoWindow: InfoWindow(
            title: 'Target Location',
            snippet: 'Latitude: ${widget.latitude}, Longitude: ${widget.longitude}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      // Show a placeholder or message when coordinates are null
      return ClipOval(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: const Text(
            "No map available",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude!, widget.longitude!),
                zoom: 9,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                mapController = controller;
                setState(() {
                  isMapLoading = false; 
                });
              },
              markers: _markers, 
            ),
            if (isMapLoading)
              Container(
                color: Colors.black45, // Semi-transparent overlay to show the indicator
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
