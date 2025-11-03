import 'package:flutter/material.dart';
import 'package:movora/utils/bottom_nav_bar.dart';
import 'package:movora/utils/custom_app_bar.dart';
import 'package:movora/views/favorite.dart';
import 'package:movora/views/home_page_content.dart';
import 'package:movora/utils/slider_menu.dart';
import 'package:movora/viewmodels/botton_nav_view_model.dart';
import 'package:movora/viewmodels/search_view_model.dart';
import 'package:movora/views/post_your_ad_page.dart';
import 'package:movora/utils/shift_hub_pickup_details.dart';
import 'package:movora/views/shift_hub_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavVM = context.watch<BottomNavViewModel>();

    final List<Widget> pages = [
      const HomePageContent(), // <-- new reusable widget
      ShiftHubScreen(),
      const PostYourAdPage(),
      const Favorite(),
    ];

    return Scaffold(
      drawer: const Drawer(child: SliderMenu()),
      appBar: CustomAppBar(searchVM: context.watch<SearchViewModel>()),
      body: pages[bottomNavVM.currentIndex],
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
