import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:uuid/uuid.dart';

import '../../business_logic/cubit/maps/maps_cubit.dart';
import '../../constants/mycolors.dart';
import '../../data/models/place_location_details.dart';
import '../../data/models/place_suggestions.dart';
import '../../data/models/routes.dart';
import '../../helpers/location_helper.dart';
import '../widgets/distance_and_time.dart';
import '../widgets/drawer.dart';
import '../widgets/floating_search_bar_widget.dart';
import '../widgets/google_map.dart';
import '../widgets/place_item.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final CameraPosition _currentLocationCameraPosition = CameraPosition(
    bearing: 0,
    target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
    tilt: 0,
    zoom: 17,
  );
  static Position? currentPosition;
  List<PlaceSuggestion>? placeSuggestions;

  final FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  final String placeSessionToken = const Uuid().v4();

  // Marker and map data
  Set<Marker> mapMarkers = {};
  late PlaceLocationDetails selectedPlaceDetails;
  late PlacePrediction selectedPlacePrediction;
  late Marker currentLocationMarker;
  late Marker searchedPlaceMarker;
  late CameraPosition searchedPlaceCameraPosition;

  // Directions and routing variables
  Routes? routes;
  bool isLoading = false;
  List<LatLng> polylineCoordinates = [];
  bool isSearchedPlaceMarkerTapped = false;
  bool isDistanceAndTimeVisible = false;
  late String travelTime;
  late String travelDistance;

  final PolylinePoints polylinePoints = PolylinePoints();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8.w, 30.h),
        child: FloatingActionButton(
          enableFeedback: true,
          onPressed: _goToCurrentLocation,
          backgroundColor: MyColors.blue,
          child: const Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          currentPosition == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.blue,
                  ),
                )
              : CustomGoogleMap(
                  markers: mapMarkers,
                  initialCameraPosition: _currentLocationCameraPosition,
                  mapController: _mapController,
                  routes: routes,
                  polylineCoordinates: polylineCoordinates,
                ),
          CustomFloatingSearchBar(
            searchBarController: floatingSearchBarController,
            isLoading: isLoading,
            onQueryChanged: _fetchPlaceSuggestions,
            onFocusChanged: (isFocused) {
              setState(() {
                isDistanceAndTimeVisible = false;
              });
            },
            suggestionBloc: _buildSuggestionsBloc(),
            selectedPlaceBlocListener: _buildSelectedPlaceBlocListener(),
            routesBloc: _buildRoutesBloc(),
          ),
          if (isSearchedPlaceMarkerTapped)
            DistanceAndTime(
              isDistanceAndTimeVisible: isDistanceAndTimeVisible,
              routes: routes,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    floatingSearchBarController.dispose();
    floatingSearchBarController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchCurrentLocation().whenComplete(() {
        setState(() {});
      });
    });
  }

  void _addMarker(Marker marker) {
    setState(() {
      mapMarkers.add(marker);
    });
  }

  void _buildNewCameraPosition() {
    searchedPlaceCameraPosition = CameraPosition(
      bearing: 0.0,
      zoom: 13,
      tilt: 0.0,
      target: LatLng(
          selectedPlaceDetails.latitude!, selectedPlaceDetails.longitude!),
    );
  }

  BlocListener _buildRoutesBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is RoutesLoaded) {
          routes = state.routes;
          _decodePolylinePoints();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  BlocListener _buildSelectedPlaceBlocListener() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlaceDetails = state.place;
          _goToSearchedPlaceLocation();
          _fetchRoutes();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        if (state is PlacesSuggestionsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.blue,
            ),
          );
        }
        if (state is PlacesLoaded && state.suggestions.isNotEmpty) {
          placeSuggestions = state.suggestions;
          return _buildSuggestionsList();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  ListView _buildSuggestionsList() {
    return ListView.builder(
      itemCount: placeSuggestions?.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            floatingSearchBarController.close();
            selectedPlacePrediction = placeSuggestions![index].placePrediction;
            _fetchPlaceLocation(selectedPlacePrediction.placeId);
            polylineCoordinates.clear();
            _clearMarkers();
          },
          child: PlaceItem(
            place: placeSuggestions![index],
          ),
        );
      },
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void _clearMarkers() {
    setState(() {
      mapMarkers.clear();
    });
  }

  void _createCurrentLocationMarker() {
    currentLocationMarker = Marker(
      markerId: const MarkerId('1'),
      onTap: () {},
      infoWindow: const InfoWindow(
        title: 'My Current Location',
      ),
      position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    _addMarker(currentLocationMarker);
  }

  void _createSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      markerId: const MarkerId('2'),
      onTap: () {
        _createCurrentLocationMarker();
        setState(() {
          isSearchedPlaceMarkerTapped = true;
          isDistanceAndTimeVisible = true;
        });
      },
      infoWindow: InfoWindow(
        title: selectedPlacePrediction.structuredFormat.secondaryText.text,
      ),
      position: searchedPlaceCameraPosition.target,
      icon: BitmapDescriptor.defaultMarker,
    );
    _addMarker(searchedPlaceMarker);
  }

  void _decodePolylinePoints() {
    polylineCoordinates = polylinePoints
        .decodePolyline(routes!.polyline!.encodedPolyline!)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  Future<void> _fetchCurrentLocation() async {
    currentPosition = await LocationHelper.determineCurrentLocation();
  }

  void _fetchPlaceLocation(String placeId) async {
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeId, placeSessionToken);
  }

  void _fetchPlaceSuggestions(String query) {
    BlocProvider.of<MapsCubit>(context)
        .emitPlacesSuggestions(query, placeSessionToken);
  }

  void _fetchRoutes() {
    BlocProvider.of<MapsCubit>(context).emitRoutes(
      LatLng(currentPosition!.latitude, currentPosition!.longitude),
      LatLng(selectedPlaceDetails.latitude!, selectedPlaceDetails.longitude!),
    );
  }

  Future<void> _goToCurrentLocation() async {
    if (currentPosition != null) {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(_currentLocationCameraPosition));
    }
  }

  void _goToSearchedPlaceLocation() async {
    _buildNewCameraPosition();
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(
            CameraUpdate.newCameraPosition(searchedPlaceCameraPosition))
        .whenComplete(() => _createSearchedPlaceMarker());
  }
}
