class Place {
  final String name;
  final String vicinity;
  // final String placeId;
  final Location location;

  const Place({
    required this.name,
    required this.vicinity,
    // required this.placeId,
    required this.location,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: (map["formatted_address"] ?? '') as String,
      vicinity: (map["vicinity"] ?? '') as String,
      // placeId: (map["place_id"] ?? '') as String,
      location: Location.fromMap((map["geometry"]["location"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  const Location({required this.lat, required this.lng});

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: (map["lat"] ?? 0.0) as double,
      lng: (map["lng"] ?? 0.0) as double,
    );
  }
}
