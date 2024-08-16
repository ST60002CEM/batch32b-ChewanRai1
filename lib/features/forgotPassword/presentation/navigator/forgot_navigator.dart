import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:finalproject/features/forgotPassword/presentation/view/verification_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordNavigatorProvider =
    Provider((ref) => ForgotPasswordNavigator());

class ForgotPasswordNavigator with DashboardViewRoute, LoginViewRoute {}

mixin ForgotPasswordRoute {
  openForgotPasswordView() {
    NavigateRoute.popAndPushRoute(const VerificationView());
  }
}
