// import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final loginViewModelProvider =
//     StateNotifierProvider<LoginViewModel, void>((ref) {
//   final navigator = ref.read(loginViewNavigatorProvider);
//   return LoginViewModel(navigator);
// });

// class LoginViewModel extends StateNotifier<void> {
//   LoginViewModel(this.navigator) : super(null);
//   final LoginViewNavigator navigator;

//   void login(String email, String password) {
//     // Add your login logic here
//     if (email == "" && password == "") {
//       openDashboard();
//     }
//   }

//   void openRegisterView() {
//     navigator.openRegisterView();
//   }

//   void openDashboard() {
//     navigator.openDashboardView();
//   }
// }
