import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movora/services/placeholder.dart';
import 'package:movora/utils/app_pattete.dart';

class carouselSlider extends StatelessWidget {
  const carouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: productImages.map((img) {
        return Container(
          decoration: BoxDecoration(
            color: AppPallete.focusBorder,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 150,
          width: 250,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(img, fit: BoxFit.cover),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 140,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
    );
  }
}
