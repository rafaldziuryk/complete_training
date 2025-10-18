import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP L3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  Future<String> fact = Future(() => '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP L3 - Dio'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            fact = Future.microtask(() async {
              final response = await Dio().get(
                'https://catfact.ninja/fact',
              );
              return response.data['fact'];
            });
          });
        },
        child: const Icon(
          Icons.play_arrow,
        ),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fact,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Wait for loading');
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      snapshot.data ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const SizedBox.shrink();
                }
            }
          },
        ),
      ),
    );
  }
}