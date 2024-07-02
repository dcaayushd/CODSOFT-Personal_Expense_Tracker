import 'package:flutter/material.dart';
import '../tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'personal Expense Tracker',
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          // backgroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          // backgroundColor: Colors.black,
          elevation: 0,
          // selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ).copyWith(
          primary: Colors.blue,
          secondary: Colors.black,
        ),
      ),
      home: const TabsSection(),
    );
  }
}
