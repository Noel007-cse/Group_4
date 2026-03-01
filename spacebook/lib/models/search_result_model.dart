class SearchResultModel {
  final int id;
  final String title;
  final String distance; // e.g. "0.5"
  final double distanceKm;
  final int pricePerHr;
  final double rating;
  final String imageUrl;
  final bool isFavorite;

  const SearchResultModel({
    required this.id,
    required this.title,
    required this.distance,
    required this.distanceKm,
    required this.pricePerHr,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
  });
}