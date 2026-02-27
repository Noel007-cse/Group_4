import 'package:flutter/material.dart';
import 'package:spacebook/models/category_item_model.dart';

const List<CategoryItemModel> categories = [
    CategoryItemModel(
      id: 'sports',
      label: 'Sports Turfs',
      icon: Icons.sports_soccer,
      bgColor: Color(0xFFE8F5E9),
      iconColor: Color(0xFF2E7D32),
    ),
    CategoryItemModel(
      id: 'study',
      label: 'Study Halls',
      icon: Icons.local_library_outlined,
      bgColor: Color(0xFFE3F2FD),
      iconColor: Color(0xFF1565C0),
    ),
    CategoryItemModel(
      id: 'libraries',
      label: 'Libraries',
      icon: Icons.menu_book_outlined,
      bgColor: Color(0xFFFFF3E0),
      iconColor: Color(0xFFE65100),
    ),
    CategoryItemModel(
      id: 'halls',
      label: 'Event Halls',
      icon: Icons.celebration_outlined,
      bgColor: Color(0xFFF3E5F5),
      iconColor: Color(0xFF6A1B9A),
    ),
  ];