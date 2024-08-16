import 'package:finalproject/features/forgotPassword/presentation/state/forgot_state.dart';
import 'package:finalproject/features/forgotPassword/presentation/viewmodel/forgot_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'success_view.dart'; // Ensure you have this import

class ResetPasswordView extends ConsumerStatefulWidget {
  final String email;

  const ResetPasswordView({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> obscurePasswordNotifier = ValueNotifier<bool>(true);

  bool _validatePassword(String password) {
    return password.length > 6;
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordViewModelProvider);
    final forgotPasswordViewModel = ref.watch(forgotPasswordViewModelProvider.notifier);

    ref.listen<ForgotPasswordState>(forgotPasswordViewModelProvider, (previous, next) {
      if (next.isPasswordReset && !previous!.isPasswordReset) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SuccessView()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Password must be more than 6 characters.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: obscurePasswordNotifier,
              builder: (context, obscurePassword, child) {
                return Column(
                  children: [
                    TextField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            obscurePasswordNotifier.value = !obscurePasswordNotifier.value;
                          },
                        ),
                      ),
                      obscureText: obscurePassword,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            obscurePasswordNotifier.value = !obscurePasswordNotifier.value;
                          },
                        ),
                      ),
                      obscureText: obscurePassword,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            if (forgotPasswordState.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                forgotPasswordState.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (otpController.text.isEmpty ||
                      newPasswordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all the fields')),
                    );
                  } else if (newPasswordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                  } else if (!_validatePassword(newPasswordController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password must be more than 6 characters')),
                    );
                  } else {
                    forgotPasswordViewModel.verifyOtpAndResetPassword(
                      widget.email, // Pass the email correctly
                      otpController.text,
                      newPasswordController.text,
                    );
                  }
                },
                child: forgotPasswordState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
