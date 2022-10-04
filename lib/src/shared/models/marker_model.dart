class MarkerModel {
  late String id;
  final double lat;
  final double lng;
  final String? address;

  MarkerModel({
    required this.lat,
    required this.lng,
    this.address,
  }) {
    id = lat.toString() + lng.toString();
  }
}
