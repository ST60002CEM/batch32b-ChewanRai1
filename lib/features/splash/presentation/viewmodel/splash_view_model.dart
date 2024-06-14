import 'package:finalproject/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  // Open Login page
  void openLoginView() {
    Future.delayed(const Duration(seconds: 1), () {
      navigator.openLoginView();
    });
  }

  // Later on we will add open home page method here as well
  void openHomeView() {
    // Your code goes here
  }
}

//Chatgpt
// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:finalproject/features/auth/presentation/view/login_view.dart';
// import 'package:flutter/material.dart';

// final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>((ref) {
//   return SplashViewModel(ref);
// });

// class SplashViewModel extends StateNotifier<void> {
//   SplashViewModel(this.ref) : super(null);

//   final Ref ref;

//   void openLoginView() {
//     Timer(const Duration(seconds: 3), () {
//       ref.read(navigatorProvider).pushReplacement(MaterialPageRoute(
//         builder: (context) => const LoginView(),
//       ));
//     });
//   }
// }
