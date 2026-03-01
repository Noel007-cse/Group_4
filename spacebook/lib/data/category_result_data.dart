import 'package:spacebook/models/search_result_model.dart';

const List<SearchResultModel> allTurfs = [
  SearchResultModel(
    id: 1,
    title: 'Olympic Green Arena',
    distance: '0.5',
    distanceKm: 0.5,
    pricePerHr: 1200,
    rating: 4.9,
    imageUrl:'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=600',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 2,
    title: 'Stellar Multi-Sports Park',
    distance: '1.2',
    distanceKm: 1.2,
    pricePerHr: 950,
    rating: 4.7,
    imageUrl:'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=600',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 3,
    title: "Champion's Court Indoor",
    distance: '2.4',
    distanceKm: 2.4,
    pricePerHr: 1500,
    rating: 4.5,
    imageUrl:'https://images.unsplash.com/photo-1504450758481-7338eba7524a?w=600',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 4,
    title: 'Green Kick Football Arena',
    distance: '3.1',
    distanceKm: 3.1,
    pricePerHr: 800,
    rating: 4.3,
    imageUrl:'https://images.unsplash.com/photo-1518604666860-9ed391f76460?w=600',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 5,
    title: 'Elite Sports Ground',
    distance: '4.0',
    distanceKm: 4.0,
    pricePerHr: 1100,
    rating: 4.6,
    imageUrl:'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=600',
    isFavorite: false,
  ),
];

const List<SearchResultModel> allLibraries = [
  SearchResultModel(
    id: 101,
    title: 'City Central Library',
    distance: '0.3',
    distanceKm: 0.3,
    pricePerHr: 80,
    rating: 4.8,
    imageUrl: 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 102,
    title: 'Knowledge Oasis Study Hall',
    distance: '0.9',
    distanceKm: 0.9,
    pricePerHr: 120,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1568667256549-094345857637?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 103,
    title: 'The Reading Room',
    distance: '1.5',
    distanceKm: 1.5,
    pricePerHr: 60,
    rating: 4.6,
    imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=600&fit=crop',
    isFavorite: false,
  ),
];

const List<SearchResultModel> allStudyHalls = [
  SearchResultModel(
    id: 201,
    title: 'Focus Study Hub',
    distance: '0.8',
    distanceKm: 0.8,
    pricePerHr: 150,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 202,
    title: 'Skyline Study Lounge',
    distance: '1.2',
    distanceKm: 1.2,
    pricePerHr: 100,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1541746972996-4e0b0f43e02a?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 203,
    title: 'Quiet Corner Study Space',
    distance: '2.0',
    distanceKm: 2.0,
    pricePerHr: 80,
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=600&fit=crop',
    isFavorite: false,
  ),
];

const List<SearchResultModel> allEventHalls = [
  SearchResultModel(
    id: 301,
    title: 'The Grand Ballroom',
    distance: '5.1',
    distanceKm: 5.1,
    pricePerHr: 8000,
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 302,
    title: 'Prestige Event Centre',
    distance: '3.4',
    distanceKm: 3.4,
    pricePerHr: 5000,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=600&fit=crop',
    isFavorite: false,
  ),
  SearchResultModel(
    id: 303,
    title: 'Royal Banquet Hall',
    distance: '6.2',
    distanceKm: 6.2,
    pricePerHr: 10000,
    rating: 4.8,
    imageUrl: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=600&fit=crop',
    isFavorite: false,
  ),
];


List<SearchResultModel> getSpacesForCategory(String categoryTitle) {
  final lower = categoryTitle.toLowerCase();
  if (lower.contains('sports turfs')) return allTurfs;
  if (lower.contains('libraries')) return allLibraries;
  if (lower.contains('study halls')) return allStudyHalls;
  if (lower.contains('event halls')) return allEventHalls;
  return [];
}
