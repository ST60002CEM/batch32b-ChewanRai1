import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/navigator/register_navigator.dart';
import 'package:finalproject/features/auth/presentation/view/login_view.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// to go to the register view
final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator with RegisterViewRoute, HomeViewRoute{}

mixin LoginViewRoute{
  openLoginView(){
    NavigateRoute.pushRoute(const LoginView());
  }
}
