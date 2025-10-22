import 'package:flutter/material.dart';
import 'package:navigation_basic/screens/home_screen.dart';

class PushAndRemoveUntilScreen extends StatelessWidget {
  const PushAndRemoveUntilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push and Remove Until Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push and Remove Until Screen',
            ),
            const Text(
              'Ten ekran został dodany za pomocą\nNavigator.pushAndRemoveUntil()',
            ),
            const Text(
              'Wszystkie poprzednie ekrany zostały usunięte ze stosu',
            ),
            ElevatedButton(
              onPressed: () {
                // Wróć do Home Screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Wróć do Home'),
            ),
            ElevatedButton(
              onPressed: () {
                // Dodaj kolejny ekran i usuń wszystkie poprzednie
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PushAndRemoveUntilScreen(),
                  ),
                  (route) => false, // Usuwa wszystkie poprzednie ekrany
                );
              },
              child: const Text('Zastąp wszystkimi nowymi'),
            ),
          ],
        ),
      ),
    );
  }
}

