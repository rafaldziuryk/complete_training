import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FlutterDataWedge fdw;
  late final StreamSubscription streamSubscription;
  final List<ScanResult> results = [];

  @override
  void initState() {
    super.initState();
    initScanner();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  Future initScanner() async {
    fdw = FlutterDataWedge();
    streamSubscription = fdw.onScanResult.listen((event) => setState(() => results.add(event)));
    await fdw.initialize();
    await fdw.createDefaultProfile(profileName: 'Scanner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner"),),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
            title: Text(result.data),
            subtitle: Text('LabelType: ${result.labelType}'),
          );
        },
        itemCount: results.length,
      ),
    );
  }
}
