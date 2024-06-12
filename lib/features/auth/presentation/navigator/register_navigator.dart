import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/auth/presentation/view/register_view.dart';

// to go to other place from the Register router
class RegisterViewNavigator {}

// called by other views to open this Register Page
mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}
