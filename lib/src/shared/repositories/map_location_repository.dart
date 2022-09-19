import '../models/marker_model.dart';

class MapLocationRepository {
  // -26.23330657036441, -51.054782264858574
  // -26.229564201999867, -51.0682147253808
  List<MarkerModel> fetchMarkers() => [
        MarkerModel(lat: -26.23330657036441, lng: -51.054782264858574),
        MarkerModel(lat: -26.229564201999867, lng: -51.0682147253808),
      ];
}
