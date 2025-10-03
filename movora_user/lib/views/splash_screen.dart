import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splshVM = Provider.of<SplashScreenViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      splshVM.initializeApp(context);
    });
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            LottieBuilder.asset('assets/XbCFuE5U1U.json'),
            Positioned(
              top: 220,
              left: 80,
              child: Text(
                'Movora',
                style: TextStyle(
                  color: AppPallete.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
