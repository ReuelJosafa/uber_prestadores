import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/marker_model.dart';

class MapLocationRepository {
  final List<MarkerModel> _destinationMarkers = [];

  void addDestinationMarker(MarkerModel marker) =>
      _destinationMarkers.add(marker);

  void addDestinationMarkers(List<MarkerModel> markers) =>
      _destinationMarkers.addAll(markers);

  List<MarkerModel> get destinationMakers => [..._destinationMarkers];

  // TODO: Modificar tranzendo localização de veículos próximos ao local de partida.
  List<MarkerModel> fetchCarMarkers(LatLng latLng) => [
        MarkerModel(lat: latLng.latitude + 0.005, lng: latLng.longitude),
        MarkerModel(lat: latLng.latitude, lng: latLng.longitude + 0.005),
        MarkerModel(
            lat: latLng.latitude + 0.005, lng: latLng.longitude + 0.005),
      ];

/*   List<MarkerModel> fetchDestinationMarkers(LatLng latLng) => [
        MarkerModel(lat: latLng.latitude + 0.005, lng: latLng.longitude),
        MarkerModel(lat: latLng.latitude, lng: latLng.longitude + 0.005),
        MarkerModel(
            lat: latLng.latitude + 0.005, lng: latLng.longitude + 0.005),
      ]; */
}
