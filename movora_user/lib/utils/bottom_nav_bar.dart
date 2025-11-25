import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/botton_nav_view_model.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavVM = context.watch<BottomNavViewModel>();

    return BottomNavigationBar(
      currentIndex: bottomNavVM.currentIndex,
      onTap: (index) => bottomNavVM.updateIndex(index),
      backgroundColor: const Color(0xFF0B1220),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppPallete.focusBorder,
      unselectedItemColor: Colors.grey.withOpacity(0.6),
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.packagePlus),
          label: "Shift Hub",
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.camera600),
          label: "Post your ad",
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.heart),
          label: "Favorites",
        ),
      ],
    );
  }
}
