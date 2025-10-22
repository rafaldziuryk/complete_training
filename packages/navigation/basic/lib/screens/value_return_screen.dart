import 'package:flutter/material.dart';

class ValueReturnScreen extends StatelessWidget {
  const ValueReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value Return Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Value Return Screen',
            ),
            const Text(
              'Ten ekran demonstruje przekazywanie wartości\nprzez Navigator.pop(context, wartość)',
            ),
            ElevatedButton(
              onPressed: () async {
                // Otwórz ekran który zwróci wartość
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ValueSenderScreen(),
                  ),
                );
                
                // Pokaż otrzymaną wartość
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Otrzymano wartość: $result'),
                    ),
                  );
                }
              },
              child: const Text('Otwórz ekran zwracający wartość'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Wróć'),
            ),
          ],
        ),
      ),
    );
  }
}

class ValueSenderScreen extends StatelessWidget {
  const ValueSenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value Sender Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Value Sender Screen',
            ),
            const Text(
              'Ten ekran zwróci wartość do poprzedniego ekranu\nza pomocą Navigator.pop(context, wartość)',
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Sukces!'),
              child: const Text('Zwróć "Sukces!"'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 42),
              child: const Text('Zwróć liczbę 42'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, {'name': 'Jan', 'age': 25}),
              child: const Text('Zwróć obiekt'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Zwróć null'),
            ),
          ],
        ),
      ),
    );
  }
}
