import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  bool _isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String _searchText = '';

  bool get isSearching => _isSearching;
  String get searchText => _searchText;

  void toggledSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
