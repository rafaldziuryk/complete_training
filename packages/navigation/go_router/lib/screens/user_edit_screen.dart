import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserEditScreen extends StatelessWidget {
  final String userId;
  
  const UserEditScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User $userId'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.edit,
              size: 100,
              color: Colors.purple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Edit User Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Edytujesz użytkownika: $userId',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            const Text(
              'To jest nested route - ekran edycji użytkownika.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Ścieżka: /user/$userId/edit',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            
            const SizedBox(height: 30),
            
            // Formularz edycji
            const Text(
              'Formularz edycji:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Imię',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Jan'),
            ),
            const SizedBox(height: 10),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nazwisko',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Kowalski'),
            ),
            const SizedBox(height: 10),
            
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'jan.kowalski@example.com'),
            ),
            
            const SizedBox(height: 30),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Zapisano zmiany!')),
                      );
                      context.pop();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Zapisz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Anuluj'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
