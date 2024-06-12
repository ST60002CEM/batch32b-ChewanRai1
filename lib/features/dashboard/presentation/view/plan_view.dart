import 'package:flutter/material.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: Text('Your monthly plan shows up here'),
      ),
    );
  }
}
