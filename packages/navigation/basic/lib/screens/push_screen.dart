import 'package:flutter/material.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push Screen',
            ),
            const Text(
              'Ten ekran został dodany do stosu nawigacji\nza pomocą Navigator.push()',
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Wróć (Pop)'),
            ),
            ElevatedButton(
              onPressed: () {
                // Dodaj kolejny ekran na stos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PushScreen(),
                  ),
                );
              },
              child: const Text('Dodaj kolejny ekran'),
            ),
          ],
        ),
      ),
    );
  }
}

