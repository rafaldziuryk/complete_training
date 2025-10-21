import 'package:di_step0/classes/classes.dart';
import 'package:flutter/material.dart';

class PageZero extends StatefulWidget {
  const PageZero({Key? key}) : super(key: key);

  @override
  State<PageZero> createState() => _PageZeroState();
}

class _PageZeroState extends State<PageZero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 0 - Basic Classes'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Step 0: Basic Classes without DI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final dataSource1 = DataSource1();
                dataSource1.hello();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('DataSource1 called directly!')),
                );
              },
              child: const Text('Call DataSource1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final dataSource2 = DataSource2();
                dataSource2.hello();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('DataSource2 called directly!')),
                );
              },
              child: const Text('Call DataSource2'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: Classes are instantiated directly without DI',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
