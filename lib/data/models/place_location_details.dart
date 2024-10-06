class PlaceLocationDetails {
  double? latitude;
  double? longitude;

  PlaceLocationDetails({this.latitude, this.longitude});

  PlaceLocationDetails.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
