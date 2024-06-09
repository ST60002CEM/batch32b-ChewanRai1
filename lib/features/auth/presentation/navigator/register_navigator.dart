import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/view/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// to go to other place from the Register router
class RegisterViewNavigator {
  void openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}

// called by other views to open this Register Page
mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}

final registerViewNavigatorProvider = Provider<RegisterViewNavigator>((ref) {
  return RegisterViewNavigator();
});
