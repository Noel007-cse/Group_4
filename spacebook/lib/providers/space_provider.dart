import 'package:flutter/material.dart';

class SpaceProvider with ChangeNotifier {
  List spaces = [];

  void setSpaces(List data) {
    spaces = data;
    notifyListeners();
  }

  void removeSpace(int id) {
    spaces.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
