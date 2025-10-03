import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onpress;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: AlignmentGeometry.center,
          colors: [AppPallete.focusBorder, AppPallete.gradient1],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          fixedSize: Size(390, 55),
        ),
        onPressed: onpress,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppPallete.whiteColor,
          ),
        ),
      ),
    );
  }
}
