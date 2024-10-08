import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:finalproject/core/common/my_snackbar.dart';
import 'package:finalproject/core/common/my_yes_no_dialog.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:finalproject/features/forgotPassword/presentation/view/verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  bool _isPasswordVisible = false;
  bool isObscure = true;
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];

        _checkGyroscopeValues(_gyroscopeValues);
      });
    }));

    super.initState();
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _checkGyroscopeValues(List<double> values) async {
    print('Gyroscope Values: X=${values[0]}, Y=${values[1]}, Z=${values[2]}');
    print('Gyroscope Values: $values');
    const double threshold = 5; // Example threshold value, adjust as needed
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await myYesNoDialog(
          title: 'Are you sure you want to send feedback?',
        );
        isDialogShowing = false;
        if (result) {
          showMySnackBar(
            message: 'Feedback sent',
            color: Colors.green,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 37.0,
              width: 37.0,
            ),
            const SizedBox(width: 8.0), // Adjusted spacing
            const Text(
              'HandyHelper',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.green,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to HandyHelper',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text('Please login to continue'),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerificationView()),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google sign-in
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Changed text color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        height: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16, // Adjusted font size
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final result = await ref
                                .read(authViewModelProvider.notifier)
                                .loginUser(
                                  _emailController.text,
                                  _passwordController.text,
                                );

                            if (result == 'error') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid credentials'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Changed button color
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New here?'),
                    TextButton(
                      child: const Text(
                        'Create an account in a minute.',
                        style: TextStyle(
                          color: Colors.green, // Changed text color
                        ),
                      ),
                      onPressed: () {
                        ref
                            .read(authViewModelProvider.notifier)
                            .openRegisterView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
