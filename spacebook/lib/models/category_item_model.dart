import 'package:flutter/material.dart';

class CategoryItemModel {
  final String id;
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const CategoryItemModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}