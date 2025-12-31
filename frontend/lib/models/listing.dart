class Listing {
  final String id;
  final String title;
  final String description;
  final String category;
  final double pricePerDay;
  final String location;
  final List<String> images;
  final String ownerId;
  final String ownerName;
  final bool ownerVerified;
  final DateTime availableFrom;
  final DateTime availableTo;
  final int? healthScore;
  final String? aiInsights;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.pricePerDay,
    required this.location,
    required this.images,
    required this.ownerId,
    required this.ownerName,
    required this.ownerVerified,
    required this.availableFrom,
    required this.availableTo,
    this.healthScore,
    this.aiInsights,
  });
}
