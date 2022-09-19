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

  SearchPlaceController(this.locationRepository);

  Future<void> searchPlaces(String searchTerm, LatLng latLng) async {
    state = SearchState.loading;
    try {
      searchResults =
          await locationRepository.getAutocomplete(searchTerm, latLng);
      notifyListeners();
    } catch (e) {
      state = SearchState.error;
      error = 'Verifique a conexão com a internet ou tente novamente.';
      notifyListeners();
    }
  }

  Future<void> setSelectedLocation(String placeId) async {
    try {
      final sLocation = await locationRepository.getPlace(placeId);
      selectedLocation = sLocation;
      notifyListeners();
    } catch (e) {
      state = SearchState.error;
      error = 'Verifique a conexão com a internet ou tente novamente.';
      notifyListeners();
    }
  }
}

enum SearchState { error, loading, success }
