// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movora/services/firebase_auth_services.dart';
import 'package:movora/utils/app_routes.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();

  Future<void> initializeApp(BuildContext context) async {
    bool loggedIn = await _authServices.isLogin();

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}
