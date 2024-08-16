import 'package:flutter/material.dart';

class TermsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome to [App Name]! These Terms and Conditions ("Terms") govern your use of our mobile application (the "App"). By using our App, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, please do not use our App.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Privacy Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.',
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
