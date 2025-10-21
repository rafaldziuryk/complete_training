import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'classes/classes.dart';
import 'di_five.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => GetIt.instance.get<UseCase3>(param1: 'Test').hello(),
              child: Text('UseCase3'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DiInit5().init();
  }

  @override
  void dispose() {
    DiInit5().deInit();
    super.dispose();
  }
}
