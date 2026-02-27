class BookingModel {
  final String id;
  final String title;
  final String date;
  final String price;
  final String imageUrl;
  final String status; // 'COMPLETED' or 'CONFIRMED'

  const BookingModel({
    required this.id,
    required this.title,
    required this.date,
    required this.price,
    required this.imageUrl,
    required this.status,
  });
}