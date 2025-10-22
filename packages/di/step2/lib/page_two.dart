import 'package:di_step2/classes/classes.dart';
import 'package:di_step2/di_two.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 2 - GetIt with Interfaces'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Step 2: GetIt with Interfaces',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final repository = GetIt.instance.get<Repository1>();
                repository.hello();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Repository1 (interface) called via GetIt!')),
                );
              },
              child: const Text('Call Repository1 (Interface)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final dataSource1 = GetIt.instance.get<DataSource1>();
                dataSource1.hello();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('DataSource1 called via GetIt!')),
                );
              },
              child: const Text('Call DataSource1'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: Using interfaces for better testability and loose coupling',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DiInit2().init();
  }

  @override
  void dispose() {
    DiInit2().deInit();
    super.dispose();
  }
}
