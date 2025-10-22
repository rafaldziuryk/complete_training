import 'package:flutter/material.dart';

class FullscreenDialogScreen extends StatelessWidget {
  const FullscreenDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fullscreen Dialog'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Zatwierdź'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Anulowano'),
              child: const Text('Anuluj'),
            ),
          ],
        ),
      ),
    );
  }
}

