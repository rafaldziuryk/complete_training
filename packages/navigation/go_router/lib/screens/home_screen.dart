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
            const Text(
              'Go Router Navigation Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Basic navigation
            _buildSectionTitle('Basic Navigation'),
            _buildNavigationButton(
              context,
              'Profile Screen',
              Icons.person,
              () => context.goNamed('profile'),
            ),
            _buildNavigationButton(
              context,
              'Settings Screen',
              Icons.settings,
              () => context.goNamed('settings'),
            ),
            
            const SizedBox(height: 20),
            
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
            
            const SizedBox(height: 20),
            
            // Query parameters
            _buildSectionTitle('Query Parameters'),
            _buildNavigationButton(
              context,
              'Profile with Query Params',
              Icons.query_stats,
              () => context.goNamed('profile', queryParameters: {
                'name': 'John Doe',
                'age': '25',
                'city': 'Warsaw',
              }),
            ),
            
            const SizedBox(height: 20),
            
            // Nested routes
            _buildSectionTitle('Nested Routes'),
            _buildNavigationButton(
              context,
              'Nested Example',
              Icons.folder,
              () => context.goNamed('nested'),
            ),
            
            const SizedBox(height: 20),
            
            // Protected routes
            _buildSectionTitle('Protected Routes'),
            _buildNavigationButton(
              context,
              'Protected Screen',
              Icons.lock,
              () => context.goNamed('protected'),
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

