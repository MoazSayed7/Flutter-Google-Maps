import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_location_details.dart';
import '../models/place_suggestions.dart';
import '../models/routes.dart';
import '../webservices/places_web_services.dart';

class MapsRepository {
  final PlacesWebServices placesWebServices;
  MapsRepository({required this.placesWebServices});

  Future<PlaceLocationDetails> getPlaceDetails(
      String placeId, String sessionToken) async {
    Map<String, dynamic> response =
        await placesWebServices.getPlaceDetails(placeId, sessionToken);

    return PlaceLocationDetails.fromJson(response);
  }

  Future<List<PlaceSuggestion>> getPlaces(
      String place, String sessionToken) async {
    List<dynamic> suggestions =
        await placesWebServices.getPlaces(place, sessionToken);
    return suggestions
        .map((suggestionJson) => PlaceSuggestion.fromJson(suggestionJson))
        .toList();
  }

  Future<Routes> getRoutes(LatLng origin, LatLng destination) async {
    final response = await placesWebServices.getRoutes(origin, destination);

    return Routes.fromJson(response[0]);
  }
}
