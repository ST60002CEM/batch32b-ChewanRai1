// import 'package:finalproject/screen/home_screen.dart';
import 'package:finalproject/screen/inbox_screen.dart';
import 'package:finalproject/screen/plan_screen.dart';
import 'package:finalproject/screen/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Column(
        children: [
          // const SizedBox(height: 16),
          Container(
            color: Colors.green,
            height: 50,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('All', Colors.amber),
                  _buildCategoryButton('Cleaner', Colors.white),
                  _buildCategoryButton('Electrician', Colors.white),
                  _buildCategoryButton('Plumber', Colors.white),
                  _buildCategoryButton('Painter', Colors.white),
                  _buildCategoryButton('More..', Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'For your home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                _buildInfoCard(
                  'Upkeep 101',
                  'Learn the basics to keep your home in great shape.',
                  'assets/images/upkeep.jpeg',
                ),
                _buildInfoCard(
                  'Energy efficiency',
                  'Learn how to conserve energy and lower costs.',
                  'assets/images/energy.jpeg',
                ),
                _buildInfoCard(
                  'Pet proofing',
                  'Make your home safe and comfortable for your pets.',
                  'assets/images/pet.jpeg',
                ),
                _buildInfoCard(
                  'Moving',
                  'Make the transition easier with these projects.',
                  'assets/images/moving.jpeg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color == Colors.amber ? Colors.amber : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: color == Colors.amber ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
