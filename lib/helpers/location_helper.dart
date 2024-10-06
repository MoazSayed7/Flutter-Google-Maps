import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  // Method to determine the current location
  static Future<Position> determineCurrentLocation() async {
    // Check if the location service is enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Future.error(
          'Location services are disabled. Please enable them in settings.');
    }

    // Check and request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'Location permissions are denied. Please grant permissions.');
      }
    }

    // Handle the case where permissions are denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied. Cannot request permissions.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );
  }

  // Helper method to prompt the user to open location settings
  static Future<void> promptEnableLocationService(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Service Disabled'),
          content:
              const Text('Please enable the location service to continue.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await Geolocator
                    .openLocationSettings(); // Open location settings
              },
            ),
          ],
        );
      },
    );
  }
}
