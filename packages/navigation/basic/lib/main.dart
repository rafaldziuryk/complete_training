import 'package:flutter/material.dart';
import 'package:navigation_basic/screens/home_screen.dart';

void main() {
  runApp(const NavigationBasicApp());
}

class NavigationBasicApp extends StatelessWidget {
  const NavigationBasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Basic Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

