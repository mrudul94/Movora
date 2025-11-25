import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:movora/models/home_page_items_model.dart';
import 'package:movora/utils/app_routes.dart';
import 'package:movora/views/my_shift.dart';
import 'package:movora/views/shift_booked.dart';

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
        HomePageItem(
          title: 'Book a Shift',
          icon: LucideIcons.packagePlus,
          onTap: (_) {},
        ),
        HomePageItem(
          title: 'Track Shipments',
          icon: LucideIcons.truck,
          onTap: (_) {},
        ),
        HomePageItem(
          title: 'Shift History',
          icon: LucideIcons.fileText,
          onTap: (ctx) =>
              Navigator.push(ctx, createAnimatedRoute(const MyShift())),
        ),
        HomePageItem(title: 'More', icon: LucideIcons.blocks, onTap: (_) {}),
      ]);
}

class CategoryVM extends BaseListViewModel {
  CategoryVM()
    : super([
        HomePageItem(
          title: 'Mobiles',
          icon: LucideIcons.smartphone,
          onTap: (_) {},
        ),
        HomePageItem(title: 'Fashion', icon: LucideIcons.shirt, onTap: (_) {}),
        HomePageItem(title: 'Furniture', icon: LucideIcons.sofa, onTap: (_) {}),
        HomePageItem(
          title: 'Electronics',
          icon: LucideIcons.monitorSmartphone,
          onTap: (_) {},
        ),
        HomePageItem(title: 'Pets', icon: LucideIcons.pawPrint, onTap: (_) {}),
        HomePageItem(title: 'More', icon: LucideIcons.blocks, onTap: (_) {}),
      ]);
}
