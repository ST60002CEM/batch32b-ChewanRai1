import 'package:finalproject/features/dashboard/presentation/view/plan_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Profile Header
          const Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                    'assets/images/profile_image.jpeg'), // Replace with your image path
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chewan Rai',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kapan, Budhanilkantha',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),

          // Menu Items
          MenuItem(
            title: 'Your Info',
            subtitle: 'Profile and Address',
            onTap: () {
              // Navigate to your info screen
            },
          ),
          MenuItem(
            title: 'Monthly plans',
            subtitle: 'Your planned projects',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlanView()),
              );

              // Navigate to monthly plans screen
            },
          ),
          MenuItem(
            title: 'To-do list',
            subtitle: 'Your service list',
            onTap: () {
              // Navigate to to-do list screen
            },
          ),
          MenuItem(
            title: 'Rating and Reviews',
            subtitle: 'Review the service or service providers',
            onTap: () {
              // Navigate to rating and reviews screen
            },
          ),
          MenuItem(
            title: 'Help and Terms of use',
            subtitle: 'Terms and condition regarding the app',
            onTap: () {
              // Navigate to help and terms of use screen
            },
          ),
          SizedBox(height: 32),

          // Log Out
          ListTile(
            title: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              // Handle log out
            },
          ),
        ],
      ),
    );
  }
}

class _screens {}

class MenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
