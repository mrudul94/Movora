import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/carousel_slider.dart';
import 'package:movora/utils/home_screen_cards.dart';
import 'package:movora/utils/search_bar.dart';
import 'package:movora/viewmodels/home_page_item_view_model.dart';
import 'package:movora/viewmodels/search_view_model.dart';
import 'package:provider/provider.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final searchVM = Provider.of<SearchViewModel>(context);

    return Stack(
      children: [
        // Main content
        SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 1500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: carouselSlider(),
                ),
                const HeadingText(text: 'Shift Hub'),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: const Color.fromARGB(122, 0, 0, 0),
                  height: 250,
                  width: double.infinity,
                  child: Consumer<ShiftHubVM>(
                    builder: (context, shiftHubVM, _) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shiftHubVM.items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = shiftHubVM.items[index];
                          return HomeScreenCard(
                            item: item,
                            isSelected: shiftHubVM.selectedIndex == index,
                            onTap: () {
                              shiftHubVM.selectItem(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const HeadingText(text: 'Marketplace'),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(122, 0, 0, 0),
                  height: 250,
                  width: double.infinity,
                  child: Consumer<CategoryVM>(
                    builder: (context, categoryVM, _) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryVM.items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = categoryVM.items[index];
                          return HomeScreenCard(
                            item: item,
                            isSelected: categoryVM.selectedIndex == index,
                            onTap: () {
                              categoryVM.selectItem(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // Search bar overlay
        if (searchVM.isSearching)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: searchVM.isSearching ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              color: AppPallete.backgroundColor.withOpacity(0.95),
              padding: const EdgeInsets.all(8),
              child: const SearchBarScreen(),
            ),
          ),
      ],
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
