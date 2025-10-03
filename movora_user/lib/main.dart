import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movora/firebase_options.dart';
import 'package:movora/utils/app_routes.dart';
import 'package:movora/utils/app_theme.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:movora/viewmodels/splash_screen_view_model.dart';
import 'package:movora/views/home_screen.dart';
import 'package:movora/views/login_screen.dart';
import 'package:movora/views/signup_page.dart';
import 'package:movora/views/splash_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenViewModel()),
        ChangeNotifierProvider(create: (_) => FirebaseAuthViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Apptheme.darkTheme,
      initialRoute: '/',
      routes: {
        AppRoutes.splash: (context) => SplashScreen(),
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.signup: (context) => SignupPage(),
      },
    );
  }
}
