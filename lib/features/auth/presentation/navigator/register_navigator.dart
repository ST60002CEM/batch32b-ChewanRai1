import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/auth/presentation/view/register_view.dart';

// to go to other place from the Register router
class RegisterViewNavigator{}

// called by other views to open this Register Page
mixin RegisterViewRoute{
  openRegisterView(){
    NavigateRoute.pushRoute(const RegisterView());
  }
}