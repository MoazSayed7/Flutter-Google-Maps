part of 'maps_cubit.dart';

final class MapsInitial extends MapsState {}

@immutable
sealed class MapsState {}

class PlaceLocationLoaded extends MapsState {
  final PlaceLocationDetails place;

  PlaceLocationLoaded(this.place);
}

class PlacesLoaded extends MapsState {
  final List<PlaceSuggestion> suggestions;

  PlacesLoaded(this.suggestions);
}

class PlacesSuggestionsLoading extends MapsState {}

class RoutesLoaded extends MapsState {
  final Routes routes;

  RoutesLoaded(this.routes);
}
