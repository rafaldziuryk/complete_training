void main() {
  // Types and variables
  int count = 1;
  double price = 19.99;
  num anyNumber = 42;
  bool isActive = true;
  String title = 'Dart Basics';
  Object anything = 'text';
  dynamic flexible = 123;

  final now = DateTime.now(); // runtime final
  const piValue = 3.1415926; // compile-time const

  print('count=$count price=$price anyNumber=$anyNumber isActive=$isActive');
  print('title=$title now=$now pi=$piValue anything=$anything flexible=$flexible');

  // Functions: positional, named, default, arrow
  print(sum(2, 3));
  print(greet('Rafał'));
  print(configure(timeoutSeconds: 5));
  print(configure(timeoutSeconds: 40));

  // Closures
  final inc = makeIncrementer(2);
  print(inc(10)); // 12
}

int sum(int a, int b) => a + b;

String greet(String name, [String suffix = '!']) {
  return 'Hello, $name$suffix';
}

Map<String, dynamic> configure(String param1, {required int timeoutSeconds, bool debug = false}) {
  return {
    'timeout': timeoutSeconds,
    'debug': debug,
  };
}

int Function(int) makeIncrementer(int by) {
  // return (int x) => x + by;
  return (int x) {return  x + by;};
}
