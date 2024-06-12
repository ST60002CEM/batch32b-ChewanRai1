import 'package:flutter/material.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: Text('You will talk to your professionals here'),
      ),
    );
  }
}
