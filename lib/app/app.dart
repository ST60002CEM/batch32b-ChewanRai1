import 'package:finalproject/screen/splash_screen.dart';
import 'package:finalproject/theme/theme_data.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      home: SplashScreen(),
    );
  }
}
