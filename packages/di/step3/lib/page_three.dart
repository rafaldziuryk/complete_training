import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'classes/classes.dart';
import 'di_three.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => GetIt.instance.get<Repository1>().hello(),
              child: Text('Repository1 '),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DiInit3().init();
  }

  @override
  void dispose() {
    DiInit3().deInit();
    super.dispose();
  }
}
