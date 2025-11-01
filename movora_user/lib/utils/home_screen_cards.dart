import 'package:flutter/material.dart';
import 'package:movora/models/home_page_items_model.dart';
import 'package:movora/utils/app_pattete.dart';

class HomeScreenCard extends StatefulWidget {
  final HomePageItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const HomeScreenCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<HomeScreenCard> createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  bool _isPressed = false; // acts like "hover"

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        width: 90,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isSelected
                ? Colors.purpleAccent
                : (_isPressed
                      ? Colors.purpleAccent
                      : AppPallete.focusBorder.withOpacity(0.6)),
            width: 1.5,
          ),
          boxShadow: [
            if (widget.isSelected || _isPressed)
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        transform: (_isPressed
            ? (Matrix4.identity()..scale(0.95))
            : Matrix4.identity()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.item.icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              widget.item.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
