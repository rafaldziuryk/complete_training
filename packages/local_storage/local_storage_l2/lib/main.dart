import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage L2',
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
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _counter = 0;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = prefs.getInt('counter') ?? 0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page One Demo'),
      ),
      body: Center(child: Text('Tapped $_counter times')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
