import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/screens/auth_screen.dart';
import 'package:industrial_iot_app/screens/bottom_nav_screen.dart';
import 'package:industrial_iot_app/screens/introPage.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Industrial IOT',
          debugShowCheckedModeBanner: false,
          home: appSnapshot.connectionState != ConnectionState.done
              ? IntroPage()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return IntroPage();
                    }
                    if (userSnapshot.hasData) {
                      return BottomNavScreen();
                    }
                    return AuthScreen();
                  },
                ),
        );
      },
    );
  }
}
