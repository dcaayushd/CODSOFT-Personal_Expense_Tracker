import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final String title = 'Settings';

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
