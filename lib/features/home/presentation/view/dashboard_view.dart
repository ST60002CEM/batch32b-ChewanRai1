import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> sliderValueNotifier =
    ValueNotifier<double>(50);
    return SizedBox.expand(
      child: Column(
        children: [
          AppBar(
            title: const Text('Dashboard View'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.replay,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
