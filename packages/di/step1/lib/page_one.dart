import 'package:di_step1/classes/classes.dart';
import 'package:di_step1/di_one.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1 - Basic GetIt'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Step 1: Basic GetIt with Singleton',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final repository = sl<Repository1Impl>();
                repository.hello();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Repository1Impl called via GetIt!')),
                );
              },
              child: const Text('Call Repository1Impl via GetIt'),
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
              child: const Text('Call DataSource1 via GetIt'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: Objects are registered as singletons in GetIt',
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
    DiInit1().init();
  }

  @override
  void dispose() {
    DiInit1().deInit();
    super.dispose();
  }
}
