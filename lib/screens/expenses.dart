import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  final String title = 'Expenses';

  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Expenses'),
      ),
    );
  }
}
