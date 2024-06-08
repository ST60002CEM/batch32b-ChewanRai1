import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:finalproject/app/themes/app_theme.dart';
import 'package:finalproject/features/splash/presentation/view/splash_view.dart';
import 'package:finalproject/screen/splash_screen.dart';
import 'package:finalproject/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Handyhelper',
      theme: AppTheme.getApplicationTheme(false),
      home: const SplashView(),
    );
  }
}
