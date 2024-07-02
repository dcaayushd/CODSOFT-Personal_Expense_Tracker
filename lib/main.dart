import 'package:flutter/cupertino.dart';
import '../tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      theme: CupertinoThemeData(
        primaryColor: Color.fromARGB(255, 41, 141, 255),
        // brightness: Brightness.light,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0D0F14),
      ),
      home: TabsController(),
    );
  }
}
