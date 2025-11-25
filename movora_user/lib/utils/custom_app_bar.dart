import 'package:flutter/material.dart';
import 'package:movora/viewmodels/search_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? image;
  CustomAppBar({super.key, required this.searchVM, this.image});

  final SearchViewModel searchVM;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: image != null && image!.isNotEmpty
              ? ClipOval(
                  child: Image.asset(
                    image!,
                    height: 36,
                    width: 36,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.account_circle, size: 36, color: Colors.white),
        ),
      ),

      actions: [
        IconButton(
          onPressed: searchVM.toggledSearch, // note: renamed correctly
          icon: const Icon(Icons.search),
          iconSize: 30,
        ),

        IconButton(
          onPressed: () {}, // note: renamed correctly
          icon: const Icon(Icons.notifications),
          iconSize: 30,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
