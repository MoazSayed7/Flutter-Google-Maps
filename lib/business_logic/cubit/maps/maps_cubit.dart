import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/place_location_details.dart';
import '../../../data/models/place_suggestions.dart';
import '../../../data/models/routes.dart';
import '../../../data/repo/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlaceLocation(String placeId, String sessionToken) async {
    await mapsRepository.getPlaceDetails(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

  void emitPlacesSuggestions(String place, String sessionToken) async {
    emit(PlacesSuggestionsLoading());
    await mapsRepository.getPlaces(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitRoutes(LatLng origin, LatLng destination) async {
    await mapsRepository.getRoutes(origin, destination).then((routes) {
      emit(RoutesLoaded(routes));
    });
  }
}
