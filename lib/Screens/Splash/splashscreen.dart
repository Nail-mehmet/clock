
import 'dart:async';

import 'package:clocker/Screens/Authentication/auth_gate.dart';
import 'package:clocker/Screens/OnBoarding/on_boarding_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool onboardingCompleted;

  SplashScreen({required this.onboardingCompleted});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Bir süre bekle ve sonra yönlendir
    Future.delayed(Duration(seconds: 2), () {
      if (widget.onboardingCompleted) {
        // Eğer onboarding tamamlanmışsa WelcomePage'e yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthGate()),
        );
      } else {
        // Onboarding tamamlanmamışsa OnboardingPage'e yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingView()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/clock.png",
            width: width/2,fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
/*
void loasSplashScreen() async {
    Timer(const Duration(seconds: 4), ()async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
    });
  }
 */