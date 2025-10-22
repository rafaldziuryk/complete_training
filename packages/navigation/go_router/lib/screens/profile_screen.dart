import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pobierz query parameters
    final queryParams = GoRouterState.of(context).uri.queryParameters;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ten ekran demonstruje przekazywanie parametrów przez query parameters.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Wyświetl query parameters jeśli istnieją
            if (queryParams.isNotEmpty) ...[
              const Text(
                'Query Parameters:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...queryParams.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('${entry.key}: ${entry.value}'),
              )),
            ] else ...[
              const Text(
                'Brak query parameters',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
            
            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('profile', queryParameters: {
                'name': 'Jan Kowalski',
                'email': 'jan@example.com',
                'role': 'admin',
              }),
              icon: const Icon(Icons.refresh),
              label: const Text('Odśwież z parametrami'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('user-detail', pathParameters: {
                'userId': '999',
              }),
              icon: const Icon(Icons.account_circle),
              label: const Text('Przejdź do User Detail'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Wróć'),
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



