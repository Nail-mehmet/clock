import 'package:clocker/Screens/Splash/splashscreen.dart';
import 'package:clocker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    // webRecaptchaSiteKey: 'your-recaptcha-site-key',
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  // SharedPreferences ile onboarding bilgisini kontrol et
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingCompleted = prefs.getBool('onboarding') ?? false;

  runApp( MyApp(onboardingCompleted: onboardingCompleted));
}

class MyApp extends StatelessWidget {
  final bool onboardingCompleted;

  MyApp({required this.onboardingCompleted});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(onboardingCompleted: onboardingCompleted,),
    );
  }
}

