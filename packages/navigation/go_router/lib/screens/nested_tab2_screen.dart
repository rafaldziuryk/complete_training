import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedTab2Screen extends StatelessWidget {
  const NestedTab2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Tab 2'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.tab,
              size: 100,
              color: Colors.deepOrange,
            ),
            const SizedBox(height: 20),
            const Text(
              'Nested Tab 2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'To jest drugi nested route.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ścieżka: /nested/tab2',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            
            const SizedBox(height: 30),
            
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Zawartość Tab 2:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('• Ustawienia'),
                    Text('• Konfiguracja'),
                    Text('• Preferencje'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('nested-tab1'),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Przejdź do Tab 1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('nested'),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Wróć do Nested'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




