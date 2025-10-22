import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Router Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Path parameters
            _buildSectionTitle('Path Parameters'),
            _buildNavigationButton(
              context,
              'User Detail (ID: 123)',
              Icons.account_circle,
              () => context.goNamed('user-detail', pathParameters: {'userId': '123'}),
            ),
            _buildNavigationButton(
              context,
              'User Detail (ID: 456)',
              Icons.account_circle,
              () => context.goNamed('user-detail', pathParameters: {'userId': '456'}),
            ),

            // Nested routes
            _buildSectionTitle('Nested Routes'),
            _buildNavigationButton(
              context,
              'Nested Example',
              Icons.folder,
              () => context.goNamed('nested'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}




