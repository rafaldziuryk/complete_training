import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedExampleScreen extends StatelessWidget {
  const NestedExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Routes Example'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.folder,
              size: 100,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            const Text(
              'Nested Routes Example',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ten ekran demonstruje nested routes w go_router.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ścieżki: /nested/tab1 i /nested/tab2',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            
            const SizedBox(height: 30),
            
            const Text(
              'Nested Routes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            _buildNestedRouteButton(
              context,
              'Tab 1',
              Icons.tab,
              '/nested/tab1',
              () => context.goNamed('nested-tab1'),
            ),
            
            _buildNestedRouteButton(
              context,
              'Tab 2',
              Icons.tab,
              '/nested/tab2',
              () => context.goNamed('nested-tab2'),
            ),
            
            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('home'),
              icon: const Icon(Icons.home),
              label: const Text('Wróć do Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNestedRouteButton(
    BuildContext context,
    String title,
    IconData icon,
    String path,
    VoidCallback onPressed,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(path),
        onTap: onPressed,
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

