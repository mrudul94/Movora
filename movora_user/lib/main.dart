import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movora/firebase_options.dart';
import 'package:movora/services/firestore_service.dart';
import 'package:movora/utils/app_routes.dart';
import 'package:movora/utils/app_theme.dart';
import 'package:movora/utils/shift_hub_pickup_details.dart';
import 'package:movora/viewmodels/botton_nav_view_model.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:movora/viewmodels/home_page_item_view_model.dart';
import 'package:movora/viewmodels/image_picker_view_model.dart';
import 'package:movora/viewmodels/search_view_model.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:movora/viewmodels/slider_menu_view_model.dart';
import 'package:movora/viewmodels/splash_screen_view_model.dart';
import 'package:movora/views/home_screen.dart';
import 'package:movora/views/login_screen.dart';
import 'package:movora/views/my_shift.dart';
import 'package:movora/views/signup_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movora/views/splash_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final imageVM = ImagePickerViewModel();
  final firestoreService = FirestoreService();
  final shiftBookingVM = ShiftBookingViewModel(
    imageVM: imageVM,
    firestoreService: firestoreService,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenViewModel()),
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthViewModel()..initUser(),
        ),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => SliderMenuViewModel()),
        ChangeNotifierProvider(create: (_) => ShiftHubVM()),
        ChangeNotifierProvider(create: (_) => CategoryVM()),
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
        ChangeNotifierProvider<ImagePickerViewModel>.value(value: imageVM),
        Provider<FirestoreService>.value(value: firestoreService),
        ChangeNotifierProvider<ShiftBookingViewModel>.value(
          value: shiftBookingVM,
        ),
      ],
      child: MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Apptheme.darkTheme,
      home: SplashScreen(),
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.signup: (context) => SignupPage(),
        AppRoutes.shiftBooking: (context) => ShiftHub(),
      },
    );
  }
}
