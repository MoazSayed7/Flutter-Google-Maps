import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/routes.dart';

class CustomGoogleMap extends StatelessWidget {
  final Set<Marker> markers;
  final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> mapController;
  final Routes? routes;
  final List<LatLng> polylineCoordinates;

  const CustomGoogleMap({
    super.key,
    required this.markers,
    required this.initialCameraPosition,
    required this.mapController,
    this.routes,
    required this.polylineCoordinates,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: initialCameraPosition,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        mapController.complete(controller);
      },
      myLocationButtonEnabled: false,
      polylines: routes != null
          ? {
              Polyline(
                polylineId: const PolylineId('1'),
                color: Colors.black,
                width: 2,
                points: polylineCoordinates,
              ),
            }
          : {},
    );
  }
}
