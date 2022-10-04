import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import '../models/place_search.dart';
import '../repositories/location_repository.dart';

class SearchPlaceController extends ChangeNotifier {
  final LocationRepository locationRepository;
  List<PlaceSearch> searchResults = [];
  late Place selectedLocation;
  String error = '';
  SearchState state = SearchState.loading;
  bool showErrorDialog = true;

  SearchPlaceController(this.locationRepository);

  Future<void> searchPlaces(String searchTerm, LatLng latLng) async {
    try {
      searchResults =
          await locationRepository.getAutocomplete(searchTerm, latLng);
    } catch (e) {
      state = SearchState.error;
      error =
          'Certifique-se de que você está conectado a uma rede Wi-Fi ou uma rede móvel e tente novamente.';
      notifyListeners();
    }
  }

  Future<void> setSelectedLocation(String placeId) async {
    state = SearchState.loading;
    notifyListeners();

    try {
      final sLocation = await locationRepository.getPlace(placeId);
      selectedLocation = sLocation;
      state = SearchState.success;
      notifyListeners();
    } catch (e) {
      state = SearchState.error;
      error =
          'Verifique a conexão com a internet ou tente novamente mais tarde.';
      notifyListeners();
    }
  }
}

enum SearchState { error, loading, success }
