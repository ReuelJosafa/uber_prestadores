import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_prestadores/src/features/schedule_ride_confirmation/models/car_marker.dart';
import 'package:uber_prestadores/src/shared/repositories/map_location_repository.dart';

class MapLocationController extends ChangeNotifier {
  double lat = 0.0;
  double lng = 0.0;
  String erro = '';
  late GoogleMapController _mapsController;
  late List<CarMarker> makers;
  final MapLocationRepository mapLocationRepository;

  MapLocationController(this.mapLocationRepository);

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    fetchLocation();
    fetchMarkers();
  }

  void fetchLocation() async {
    try {
      Position posicao = await _fetchCurrencyLocation();
      lat = posicao.latitude;
      lng = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _fetchCurrencyLocation() async {
    LocationPermission locationPermission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Por favor, habilite a localização no seu celular.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void fetchMarkers() {
    makers = mapLocationRepository.fetchMarkers();
  }
}
