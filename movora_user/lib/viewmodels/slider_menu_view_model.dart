import 'package:flutter/material.dart';

class SliderMenuViewModel extends ChangeNotifier {
  String _selectedItem = 'Home'; // default selected item
  bool _isMenuOpen = false;

  String get selectedItem => _selectedItem;
  bool get isMenuOpen => _isMenuOpen;

  void selectItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }
}
