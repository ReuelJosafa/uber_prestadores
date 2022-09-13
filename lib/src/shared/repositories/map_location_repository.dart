import '../../features/schedule_ride_confirmation/models/car_marker.dart';

class MapLocationRepository {
  // -26.23330657036441, -51.054782264858574
  // -26.229564201999867, -51.0682147253808
  List<CarMarker> fetchMarkers() => [
        CarMarker(
            id: 'car1', lat: -26.23330657036441, lng: -51.054782264858574),
        CarMarker(id: 'car2', lat: -26.229564201999867, lng: -51.0682147253808),
      ];
}
