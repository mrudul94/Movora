import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:movora/models/home_page_items_model.dart';

/// Generic ViewModel for any list of HomePageItem
class BaseListViewModel extends ChangeNotifier {
  final List<HomePageItem> _items;
  int _selectedIndex = -1;

  BaseListViewModel(this._items);

  List<HomePageItem> get items => _items;
  int get selectedIndex => _selectedIndex;

  void selectItem(int index) {
    if (index >= 0 && index < _items.length) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}

class ShiftHubVM extends BaseListViewModel {
  ShiftHubVM()
    : super([
        HomePageItem(title: 'Book a Shift', icon: LucideIcons.packagePlus),
        HomePageItem(title: 'Track Shipments', icon: LucideIcons.truck),
        HomePageItem(title: 'Shift History', icon: LucideIcons.fileText),
        HomePageItem(title: 'More', icon: LucideIcons.blocks),
      ]);
}

class CategoryVM extends BaseListViewModel {
  CategoryVM()
    : super([
        HomePageItem(title: 'Mobiles', icon: LucideIcons.smartphone),
        HomePageItem(title: 'Fashion', icon: LucideIcons.shirt),
        HomePageItem(title: 'Furniture', icon: LucideIcons.sofa),
        HomePageItem(title: 'Electronics', icon: LucideIcons.monitorSmartphone),
        HomePageItem(title: 'Pets', icon: LucideIcons.pawPrint),
        HomePageItem(title: 'More', icon: LucideIcons.blocks),
      ]);
}
