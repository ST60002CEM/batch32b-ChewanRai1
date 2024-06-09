import 'dart:io';

import 'package:finalproject/features/auth/presentation/navigator/register_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel extends StateNotifier<void> {
  RegisterViewModel(this.navigator) : super(null);

  final RegisterViewNavigator navigator;

  void openRegisterView() {
    navigator.openRegisterView();
  }

  File? _img;

  Future<void> browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  File? get img => _img;
}

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, void>((ref) {
  final navigator = ref.read(registerViewNavigatorProvider);
  return RegisterViewModel(navigator);
});
