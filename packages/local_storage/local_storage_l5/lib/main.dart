import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_l5/counter.dart';
import 'package:local_storage_l5/counter_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage L5',
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
  CounterHive _counter = CounterHive(value: 0);

  late final Box box;

  Future<void> _incrementCounter() async {
    final counter = CounterHive(value: _counter.value + 1);
    box.put('counter4', counter);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter().then((value) async {
      if (!Hive.isAdapterRegistered(CounterAdapter().typeId)) {
        Hive.registerAdapter(CounterAdapter());
      }
      box = await Hive.openBox('Counter2');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = box.get('counter4', defaultValue: CounterHive(value: 0));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Four Demo'),
      ),
      body: Center(child: Text('Tapped ${_counter.value} times')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
