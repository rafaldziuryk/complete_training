import 'package:flutter/material.dart';
import 'package:navigation_basic/screens/home_screen.dart';

class PushReplacementScreen extends StatelessWidget {
  const PushReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Replacement Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push Replacement Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ten ekran zastąpił poprzedni ekran\nza pomocą Navigator.pushReplacement()',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Poprzedni ekran został usunięty ze stosu nawigacji',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cofnij ekran'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  )),
              child: const Text('Przejdź do Home'),
            ),
            ElevatedButton(
              onPressed: () {
                // Zastąp ten ekran nowym
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PushReplacementScreen(),
                  ),
                );
              },
              child: const Text('Zastąp nowym ekranem'),
            ),
          ],
        ),
      ),
    );
  }
}
