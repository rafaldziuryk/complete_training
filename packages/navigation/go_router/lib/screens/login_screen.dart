import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.login,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Login Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ten ekran demonstruje redirect logic w go_router.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'W prawdziwej aplikacji sprawdzalibyśmy stan autoryzacji.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            
            const SizedBox(height: 30),
            
            // Symulacja logowania
            ElevatedButton.icon(
              onPressed: () {
                // W prawdziwej aplikacji tutaj byłaby logika logowania
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Zalogowano! Przekierowanie...')),
                );
                
                // Symulacja udanego logowania - przekierowanie do home
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted) {
                    context.goNamed('home');
                  }
                });
              },
              icon: const Icon(Icons.login),
              label: const Text('Zaloguj się'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton.icon(
              onPressed: () => context.goNamed('home'),
              icon: const Icon(Icons.home),
              label: const Text('Pomiń logowanie'),
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
