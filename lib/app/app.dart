import 'package:finalproject/screen/login_screen.dart';
import 'package:finalproject/screen/register_screen.dart';
import 'package:finalproject/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
