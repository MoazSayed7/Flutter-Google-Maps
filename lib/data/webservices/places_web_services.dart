import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/strings.dart';
import '../../helpers/dio_factory.dart';

class PlacesWebServices {
  Dio dio = DioFactory.getDio();
  // Get Place Details
  Future<dynamic> getPlaceDetails(String placeId, String sessionToken) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': googleAPIKey,
        'X-Goog-FieldMask': 'location'
      };

      Response response = await dio.get(
        '$placesGoogleApiUrl/$placeId?sessionToken=$sessionToken',
        options: Options(
          headers: headers,
        ),
      );

      return response.data['location'];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Get Place Suggestions
  Future<dynamic> getPlaces(String place, String sessionToken) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': googleAPIKey
      };
      String data = json.encode(
        {
          "input": place,
          "includedRegionCodes": "eg",
          "sessionToken": sessionToken
        },
      );
      Response response = await dio.post(
        '$placesGoogleApiUrl:autocomplete',
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      return response.data['suggestions'];
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  // Get Directions
  Future<dynamic> getRoutes(LatLng origin, LatLng destination) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': googleAPIKey,
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
      };
      String data = json.encode({
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude
            }
          }
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude
            }
          }
        },
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false
        },
        "languageCode": "en-US",
        "units": "IMPERIAL"
      });
      Response response = await dio.post(
        routesGoogleApiUrl,
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      return response.data['routes'];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
