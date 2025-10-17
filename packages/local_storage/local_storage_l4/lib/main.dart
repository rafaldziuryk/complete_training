import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage L4',
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
  int _counter = 0;

  late final Box box;

  Future<void> _incrementCounter() async {
    final counter = _counter + 1;
    box.put('counter', counter);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter().then((value) async {
      box = await Hive.openBox('Counter');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = box.get('counter', defaultValue: 0);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Three Demo'),
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
