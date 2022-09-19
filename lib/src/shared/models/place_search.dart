class PlaceSearch {
  final String description;
  final String placeId;
  final StructuredFormatting details;

  PlaceSearch(
      {required this.description,
      required this.placeId,
      required this.details});

  factory PlaceSearch.fromMap(Map<String, dynamic> map) {
    return PlaceSearch(
      description: (map["description"] ?? '') as String,
      placeId: (map["place_id"] ?? '') as String,
      details: StructuredFormatting.fromMap((map["structured_formatting"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }
}

class StructuredFormatting {
  final String mainText;
  final String secondaryText;

  StructuredFormatting({required this.mainText, required this.secondaryText});

  factory StructuredFormatting.fromMap(Map<String, dynamic> map) {
    return StructuredFormatting(
      mainText: (map["main_text"] ?? '') as String,
      secondaryText: (map["secondary_text"] ?? '') as String,
    );
  }
}
