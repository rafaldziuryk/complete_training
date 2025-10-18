import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP L1',
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
  String fact = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP L1 - Basic HTTP'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final url = Uri.parse('https://catfact.ninja/fact');
          http.get(url).then((response) {
            print(response.body);
            final json = jsonDecode(response.body);
            print(json);
            setState(() {
              fact = json['fact'];
            });
          });
          print('run get');
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            fact.isEmpty ? 'Tap the play button to get a cat fact!' : fact,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}