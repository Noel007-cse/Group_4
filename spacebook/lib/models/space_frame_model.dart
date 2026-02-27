class SpaceFrameModel {
  final String id;
  final String title;
  final String distance;
  final String price;
  final String rating;
  final String image;
  bool isFavorite;

  SpaceFrameModel({
    required this.id,
    required this.title,
    required this.distance,
    required this.price,
    required this.rating,
    required this.image,
    this.isFavorite = false,
  });
}