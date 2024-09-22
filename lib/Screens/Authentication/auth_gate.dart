
import 'package:clocker/Screens/Authentication/login_or_register.dart';
import 'package:clocker/Screens/Authentication/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:myprinter/services/auth/login_or_register.dart';
//import 'package:myprinter/pages/home_page.dart';
//import 'package:myprinter/services/auth/nav_bar.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return  NavBar();
          }else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
