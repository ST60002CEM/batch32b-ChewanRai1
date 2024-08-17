import 'dart:io';

import 'package:finalproject/core/common/my_snackbar.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:user_management_starter/core/common/my_snackbar.dart';
// import 'package:user_management_starter/features/auth/domain/entity/auth_entity.dart';
// import 'package:user_management_starter/features/auth/domain/usecases/auth_usecase.dart';
// import 'package:user_management_starter/features/auth/presentation/navigator/login_navigator.dart';
// import 'package:user_management_starter/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  // Future<void> registerUser(AuthEntity user) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await authUseCase.registerUser(user);
  //   data.fold(
  //     (failure) {
  //       state = state.copyWith(
  //         isLoading: false,
  //         error: failure.error,
  //         // error: failure.error,
  //       );
  //       // showMySnackBar(message: failure.error, color: Colors.red);
  //     },
  //     (success) {
  //       state = state.copyWith(isLoading: false, error: null);
  //       // showMySnackBar(message: "Successfully registered");
  //     },
  //   );
  // }
  Future<String> registerUser(AuthEntity user) async {
  state = state.copyWith(isLoading: true);
  var data = await authUseCase.registerUser(user);
  return data.fold(
    (failure) {
      state = state.copyWith(
        isLoading: false,
        error: failure.error,
      );
      return 'error';
    },
    (success) {
      state = state.copyWith(isLoading: false, error: null);
      return 'success';
    },
  );
}

  Future<String> loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    return data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        return 'error';
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeView();
        return 'success';
      },
    );
  }

  Future<void> logoutUser() async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.logoutUser();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openLoginView();
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openHomeView() {
    navigator.openDashboardView();
  }

  void openLoginView() {
    navigator.openLoginView();
  }
}
