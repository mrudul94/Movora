import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchVm = Provider.of<SearchViewModel>(context);

    return TextField(
      controller: searchVm.searchController,
      autofocus: true,
      cursorColor: AppPallete.focusBorder,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: AppPallete.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppPallete.focusBorder, width: 1.2),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.cancel_outlined, color: Colors.white),
          onPressed: () {
            searchVm.searchController.clear();
            searchVm.updateSearchText('');
            searchVm.toggledSearch();
          },
        ),
      ),
      onChanged: searchVm.updateSearchText,
    );
  }
}
