import 'package:flutter/widgets.dart';

/// Generic model for any item with a title and icon
class HomePageItem {
  final String title;
  final IconData icon;

  final Function(BuildContext) onTap;

  HomePageItem({required this.title, required this.icon, required this.onTap});
}
