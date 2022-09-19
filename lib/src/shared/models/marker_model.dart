class MarkerModel {
  late String id;
  final double lat;
  final double lng;

  MarkerModel({
    required this.lat,
    required this.lng,
  }) {
    id = lat.toString() + lng.toString();
  }
}
