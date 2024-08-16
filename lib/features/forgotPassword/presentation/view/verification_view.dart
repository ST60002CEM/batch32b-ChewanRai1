import 'package:finalproject/features/forgotPassword/presentation/viewmodel/forgot_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reset_password_view.dart'; // Ensure you have this import

class VerificationView extends ConsumerStatefulWidget {
  const VerificationView({super.key});

  @override
  ConsumerState<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends ConsumerState<VerificationView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordViewModel =
        ref.watch(forgotPasswordViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
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
              'Please enter your e-mail to receive verification code.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty &&
                      mobileController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your email')),
                    );
                  } else {
                    forgotPasswordViewModel
                        .sendForgotPasswordEmail(emailController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ResetPasswordView(email: emailController.text)),
                    );
                  }
                },
                child: const Text('Send'),
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
