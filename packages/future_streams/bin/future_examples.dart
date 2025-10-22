import 'dart:async';

void main() async {
  await futureExamples();
}

Future<void> futureExamples() async {
  print('\n🔮 FUTURE PRZYKŁADY:');
  
  await basicFuture();
  await futureWithError();
  await futureWait();
  await futureTimeout();
  await futureThenCatchError();
}

Future<void> basicFuture() async {
  print('\n1. Podstawowy Future:');
  
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Dane pobrane!';
  }
  
  final result = await fetchData();
  print('   Wynik: $result');
}

Future<void> futureWithError() async {
  print('\n2. Future z błędem:');
  
  Future<String> riskyOperation() async {
    await Future.delayed(Duration(milliseconds: 500));
    throw Exception('Błąd połączenia!');
  }
  
  try {
    final result = await riskyOperation();
    print('   Wynik: $result');
  } catch (e) {
    print('   Błąd: $e');
  }
}

Future<void> futureWait() async {
  print('\n3. Future.wait - równoległe wykonanie:');
  
  Future<String> fetchUser(int id) async {
    await Future.delayed(Duration(milliseconds: 100));
    return 'Użytkownik $id';
  }
  
  final stopwatch = Stopwatch()..start();
  final results = await Future.wait([
    fetchUser(1),
    fetchUser(2),
    fetchUser(3),
  ]);
  stopwatch.stop();
  
  print('   Wyniki: $results');
  print('   Czas: ${stopwatch.elapsedMilliseconds}ms');
}

Future<void> futureTimeout() async {
  print('\n4. Future.timeout:');
  
  Future<String> slowOperation() async {
    await Future.delayed(Duration(seconds: 5));
    return 'Dane pobrane!';
  }
  
  try {
    final result = await slowOperation().timeout(Duration(seconds: 2));
    print('   Wynik: $result');
  } on TimeoutException catch (e) {
    print('   Timeout: $e');
  }
}

Future<void> futureThenCatchError() async {
  print('\n5. Future.then i catchError:');
  
  Future<int> divide(int a, int b) async {
    await Future.delayed(Duration(milliseconds: 100));
    if (b == 0) throw Exception('Dzielenie przez zero!');
    return a ~/ b;
  }
  
  // Sukces
  divide(10, 2).then((result) {
    print('   Wynik: $result');
  }).catchError((error) {
    print('   Błąd: $error');
  });
  
  // Błąd
  divide(10, 0).then((result) {
    print('   Wynik: $result');
  }).catchError((error) {
    print('   Błąd: $error');
  });
  
  await Future.delayed(Duration(milliseconds: 200));
}
