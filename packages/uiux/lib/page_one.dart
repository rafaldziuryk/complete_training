import 'package:flutter/material.dart';
import 'package:uiux1/page_two.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page One'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Click'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PageTwo(),
            ));
          },
        ),
      ),
    );
  }
}
