
import 'dart:async';

import 'package:clocker/homepage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loasSplashScreen();
  }
  void loasSplashScreen() async {
    Timer(const Duration(seconds: 4), ()async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
