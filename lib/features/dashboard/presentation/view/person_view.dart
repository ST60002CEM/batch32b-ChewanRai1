import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:finalproject/features/dashboard/presentation/view/plan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/core/common/my_yes_no_dialog.dart';

class PersonView extends ConsumerWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 32),

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
                MaterialPageRoute(builder: (context) => const PlanView()),
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
          const SizedBox(height: 32),

          // Log Out
          ListTile(
            title: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () async {
              final confirmed = await myYesNoDialog(
                  title: "Are you sure you want to log out?");
              if (confirmed) {
                await ref.read(authViewModelProvider.notifier).logoutUser();
                if (!context.mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              }
            },
          ),
          if (logoutState is AsyncError) ...[
            const SizedBox(height: 8),
            Text(
              logoutState.error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
