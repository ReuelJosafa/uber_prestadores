import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_prestadores/src/shared/models/marker_model.dart';
import 'package:uber_prestadores/src/shared/models/place.dart';
import 'package:uber_prestadores/src/shared/repositories/map_location_repository.dart';

import '../models/direction_model.dart';
import '../repositories/location_repository.dart';

class MapLocationController extends ChangeNotifier {
  var latLng = const LatLng(0.0, 0.0);
  String error = '';
  MapLocationState mapLocationState = MapLocationState.loading;
  late GoogleMapController _mapController;
  late GoogleMapController _secondMapController;
  late List<MarkerModel> _carMarkers;
  List<MarkerModel> _destinationMarkers = [];
  final MapLocationRepository mapLocationRepository;
  final LocationRepository locationRepository;
  MarkerModel? _originMarker;
  MarkerModel? _destinationMarker;
  DirectionModel? _directionModel;

  MapLocationController(this.mapLocationRepository, this.locationRepository);

  List<MarkerModel> get carMarkers => [..._carMarkers];
  List<MarkerModel> get destinationMarkers => [..._destinationMarkers];

/*   bool isThereNoInDestinationmarkersList(MarkerModel markerModel) {
    return !_destinationMarkers
        .contains((MarkerModel dMarker) => dMarker.id == markerModel.id);
  } */

  onMapCreated(GoogleMapController gmc) async {
    _mapController = gmc;
    await fetchLocation();
    //TODO: Chamei este método para simular a criação de marcadores ao inicializar o primeiro mapa.
    fetchDestinationMarkers();
  }

  onSecondMapCreated(GoogleMapController gmc) async {
    _secondMapController = gmc;
    await fetchLocation(isSecondMap: true);
    // fetchDestinationMarkers();
  }

  Future<void> fetchLocation({bool isSecondMap = false}) async {
    mapLocationState = MapLocationState.loading;
    notifyListeners();
    try {
      Position posicao = await locationRepository.fetchCurrentLocation();
      final lat = posicao.latitude;
      final lng = posicao.longitude;
      latLng = LatLng(lat, lng);
      mapLocationState = MapLocationState.success;
      notifyListeners();

      if (!isSecondMap) {
        animateCameraTo(latLng);
      }
    } catch (e) {
      mapLocationState = MapLocationState.error;

      if (e.toString().contains('The location service')) {
        error = 'O serviço de localização do dispositivo está desabilitado.';
      } else {
        error = e.toString();
      }
      notifyListeners();
    }
  }

  void animateCameraTo(LatLng newLatLng, {bool isSecondMap = false}) {
    if (isSecondMap) {
      _secondMapController.animateCamera(CameraUpdate.newLatLng(newLatLng));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(newLatLng));
    }
  }

  void animateCamera(CameraUpdate cameraUpdate, {bool isSecondMap = false}) {
    _secondMapController.animateCamera(cameraUpdate);
  }

  void fetchDestinationMarkers() {
    mapLocationRepository.addDestinationMarkers([
      MarkerModel(lat: latLng.latitude + 0.010, lng: latLng.longitude),
    ]);
    _destinationMarkers = mapLocationRepository.destinationMakers;
    notifyListeners();
  }

  void addDestination() {
    mapLocationRepository.addDestinationMarker(_destinationMarker!);
    _destinationMarkers = mapLocationRepository.destinationMakers;
    notifyListeners();
  }

  void fetchCarMarkers() {
    if (_originMarker != null) {
      final latLng = LatLng(_originMarker!.lat, _originMarker!.lng);
      _carMarkers = mapLocationRepository.fetchCarMarkers(latLng);
      notifyListeners();
    }
  }

  MarkerModel? getOriginMarker() => _originMarker;

  set originMarker(MarkerModel newMarker) {
    _originMarker = newMarker;
    notifyListeners();
  }

  MarkerModel? getDestinationMarker() => _destinationMarker;

  set destinationMarker(MarkerModel? newMarker) {
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
