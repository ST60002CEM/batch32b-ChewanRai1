import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<void>{
  LoginViewModel(this.Navigator): super(null);
  final LoginviewNavigator navigator;
}