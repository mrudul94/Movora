import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class Tiger_animation extends StatelessWidget {
  const Tiger_animation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAuthViewModel>(
      builder: (context, authVM, child) {
        return authVM.isTypingPassword
            ? LottieBuilder.asset(
                'assets/json/Meditating Tiger.json',
                key: ValueKey(authVM.isTypingPassword),
              )
            : LottieBuilder.asset(
                'assets/json/Cute Tiger (1).json',
                key: ValueKey(authVM.isTypingPassword),
              );
      },
    );
  }
}
