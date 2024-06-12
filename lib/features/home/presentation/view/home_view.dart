import 'package:finalproject/features/home/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const DashboardView(),
    // const BatchView(),
    // const CourseView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // it will fix the issue if we add 4 items
        backgroundColor: Colors.greenAccent,
        items: const [
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(label: 'Batch', icon: Icon(Icons.light)),
          BottomNavigationBarItem(label: 'Course', icon: Icon(Icons.book)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person_2)),
        ],
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
