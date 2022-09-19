import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_prestadores/src/shared/models/marker_model.dart';
import 'package:uber_prestadores/src/shared/repositories/map_location_repository.dart';

import '../models/direction_model.dart';
import '../repositories/location_repository.dart';

class MapLocationController extends ChangeNotifier {
  var latLng = const LatLng(0.0, 0.0);
  String error = '';
  MapLocationState mapLocationState = MapLocationState.loading;
  late GoogleMapController _mapsController;
  late List<MarkerModel> _carMakers;
  // late List<MarkerModel> _carMakers;
  final MapLocationRepository mapLocationRepository;
  final LocationRepository locationRepository;
  MarkerModel? _originMarker;
  MarkerModel? _destinationMarker;
  DirectionModel? _directionModel;

  MapLocationController(this.mapLocationRepository, this.locationRepository);

  List<MarkerModel> get markers => [..._carMakers];

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    fetchLocation();
    fetchMarkers();
  }

  void fetchLocation() async {
    try {
      Position posicao = await locationRepository.fetchCurrentLocation();
      final lat = posicao.latitude;
      final lng = posicao.longitude;
      latLng = LatLng(lat, lng);
      mapLocationState = MapLocationState.success;
      notifyListeners();

      animateCameraTo(latLng);
    } catch (e) {
      mapLocationState = MapLocationState.error;

      error = e.toString();
      notifyListeners();
    }
  }

  void animateCameraTo(LatLng newLatLng) {
    _mapsController.animateCamera(CameraUpdate.newLatLng(newLatLng));
  }

  void animateCamera(CameraUpdate cameraUpdate) {
    _mapsController.animateCamera(cameraUpdate);
  }

  void fetchMarkers() {
    _carMakers = mapLocationRepository.fetchMarkers();
    notifyListeners();
  }

  MarkerModel? getOriginMarker() => _originMarker;

  set originMarker(MarkerModel newMarker) {
    _originMarker = newMarker;
    notifyListeners();
  }

  MarkerModel? getDestinationMarker() => _destinationMarker;

  set destinationMarker(MarkerModel newMarker) {
    _destinationMarker = newMarker;
    notifyListeners();
  }

  Future<void> fetchDirections() async {
    final origin = '${_originMarker!.lat},${_originMarker!.lng}';
    final destination = '${_destinationMarker!.lat},${_destinationMarker!.lng}';
    try {
      _directionModel = await locationRepository.getDirections(
          origin: origin, destination: destination);
    } catch (e) {
      error = 'Verifique sua conexão de internet ou tente novamente.';
    }
    notifyListeners();
  }

  DirectionModel? getDirections() => _directionModel;
}

enum MapLocationState { loading, error, success }
