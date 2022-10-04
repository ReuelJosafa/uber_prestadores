import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_prestadores/src/shared/models/direction_model.dart';

import '../models/place.dart';
import '../models/place_search.dart';
import 'client_http.dart';

class LocationRepository {
  final ClientHttp clientHttp;
  final _apikey = 'AIzaSyCkCkMkn1VwxiSb2dKPhsGFc3-6xIt1rw8';

  LocationRepository(this.clientHttp);

  Future<Position> fetchCurrentLocation() async {
    LocationPermission locationPermission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          'Por favor, habilite a localização no seu celular. Feche o app e o abra novamente para habilitar.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error(
            'Você precisa autorizar o acesso à localização. Feche o app e o abra novamente para habilitar.');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Você precisa autorizar o acesso à localização. Vá até as configurações do app e habilite esta opção.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<PlaceSearch>> getAutocomplete(
      String search, LatLng latLng) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&language=pt_BR'
        '&components=country:br&location=${latLng.latitude}%2C${latLng.longitude}&radius=50000&key=$_apikey';

    final response = await clientHttp.get(url);
    final placesMapped = response['predictions'] as List;
    return placesMapped.map((place) => PlaceSearch.fromMap(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apikey';
    final response = await clientHttp.get(url);

    return Place.fromMap(response["result"] as Map<String, dynamic>);
  }

  Future<DirectionModel> getDirections(
      {required String origin, required String destination}) async {
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=driving&key=$_apikey';
    final response = await clientHttp.get(url);
    return DirectionModel.fromMap(
        response['routes'][0] as Map<String, dynamic>);
  }
}
