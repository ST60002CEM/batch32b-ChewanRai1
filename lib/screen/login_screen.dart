import 'package:flutter/material.dart';

void main() {
  runApp(const HandyHelperApp());
}

class HandyHelperApp extends StatelessWidget {
  const HandyHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyHelper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HandyHelper'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hey, Welcome Back',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Please login to continue'),
            const SizedBox(height: 24.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Implement forgot password functionality
              },
              child: const Text('Forgot password?'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement login functionality
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            OutlinedButton.icon(
              onPressed: () {
                // Implement Google login functionality
              },
              icon: Image.asset(
                'assets/google_logo.png',
                height: 24.0,
              ),
              label: const Text('Continue with Google'),
            ),
            const SizedBox(height: 24.0),
            TextButton(
              onPressed: () {
                // Navigate to sign up screen
              },
              child: const Text('New here? Create an account in a minute.'),
            ),
          ],
        ),
      ),
    );
  }
}