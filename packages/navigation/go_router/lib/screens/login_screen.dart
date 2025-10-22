import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                isLoggedIn = true;

                // Symulacja udanego logowania - przekierowanie do home
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted) {
                    context.goNamed('home');
                  }
                });
              },
              label: const Text('Zaloguj się'),
            ),
          ],
        ),
      ),
    );
  }
}
