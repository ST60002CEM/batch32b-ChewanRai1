import 'package:finalproject/screen/home_screen.dart';
import 'package:finalproject/screen/inbox_screen.dart';
import 'package:finalproject/screen/plan_screen.dart';
import 'package:finalproject/screen/search_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    PlanScreen(),
    InboxScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Screen"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 2,
      ),
      // body: const Center(
      //   child: Text('Dashboard Screen'),
      // ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album_outlined),
            label: 'Inbox',
          ),
        ],
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
