import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';

class BookingNavigationButtons extends StatelessWidget {
  final bool showPrevious;
  final bool isLastStep;
  final VoidCallback onPrevious;
  final VoidCallback onNextOrConfirm;

  const BookingNavigationButtons({
    super.key,
    required this.showPrevious,
    required this.isLastStep,
    required this.onPrevious,
    required this.onNextOrConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showPrevious)
            ElevatedButton(
              onPressed: onPrevious,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Previous",
                style: TextStyle(color: AppPallete.whiteColor),
              ),
            ),
          ElevatedButton(
            onPressed: onNextOrConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: isLastStep ? Colors.blue : Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              isLastStep ? "Confirm" : "Next",
              style: TextStyle(color: AppPallete.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
