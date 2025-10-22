import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'classes/classes.dart';
import 'di_four.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => GetIt.instance.get<UseCase2>().hello(),
              child: Text('UseCase2'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DiInit4().init();
  }

  @override
  void dispose() {
    DiInit4().deInit();
    super.dispose();
  }
}
