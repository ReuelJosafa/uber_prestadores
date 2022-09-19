import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionModel {
  final LatLng boundsNe;
  final LatLng boundsSw;
  final String polyline;
  final List<PointLatLng> polylineDecoded;

  const DirectionModel({
    required this.boundsNe,
    required this.boundsSw,
    required this.polyline,
    required this.polylineDecoded,
  });

  factory DirectionModel.fromMap(Map<String, dynamic> map) {
    return DirectionModel(
      boundsNe: LatLng((map["bounds"]['northeast']['lat'] ?? 0.0) as double,
          (map["bounds"]['northeast']['lng'] ?? 0.0) as double),
      boundsSw: LatLng((map["bounds"]['southwest']['lat'] ?? 0.0) as double,
          (map["bounds"]['southwest']['lng'] ?? 0.0) as double),
      polyline: (map['overview_polyline']['points'] ?? '') as String,
      polylineDecoded: PolylinePoints()
          .decodePolyline((map['overview_polyline']['points'] ?? '') as String),
    );
  }

  @override
  String toString() {
    return 'DirectionModel(boundsNe: $boundsNe, boundsSw: $boundsSw, polyline: $polyline, polylineDecoded: $polylineDecoded)';
  }
}
