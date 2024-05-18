import 'package:finalproject/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final bool _agreeToTerms = false;

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
            const SizedBox(width: 0.0),
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
        color: Colors.white, // Set the background color here
        alignment: Alignment.center, // keeps whole contains in center
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Create an account',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 45.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email address',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: <Widget>[
                  Expanded(
                    // Ensures text fills remaining space and centers
                    child: Text(
                      'By signing up, you agree to our Terms & Conditions and Privacy Policy',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Signup'),
                onPressed: () {
                  // Handle signup logic here
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
