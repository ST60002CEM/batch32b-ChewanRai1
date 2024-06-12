import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, void>((ref) {
  final navigator = ref.read(loginViewNavigatorProvider);
  return LoginViewModel(navigator);
});

class LoginViewModel extends StateNotifier<void> {
  LoginViewModel(this.navigator) : super(null);
  final LoginViewNavigator navigator;

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openDashboard() {
    navigator.openDashboardView();
  }
}
