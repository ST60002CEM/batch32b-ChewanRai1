import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewNavigatorProvider = Provider((ref) => SplashViewNavigator());

class SplashViewNavigator with LoginViewRoute {}

mixin SplashViewRoute {}
